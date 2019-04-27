import hdf5.hdf5;
import hdf5.head;
import std.stdio;
import std.conv:to;
import std.algorithm:sort,map,filter;
import std.array:array;
import std.file:exists;
import std.string:toStringz;

void main(string[] args)
{
	writefln("file: %s",args[1]);
	writeln(hdf5Contents(args[1]));
}

string[] hdf5Contents(string filename)
{
	import std.exception:enforce;
	string[] files;
	hid_t handle;
	enforce(filename.exists,new Exception("hdf5Contents - file: "~filename~" does not exist!"));
	try
	{
		auto file=H5F.open(filename,H5F_ACC_RDWR, H5P_DEFAULT);
		files=sort(cast(string[])objectList(file).filter!(a=>(a!="." && a!="..")).array).array;
		H5F.close(file);
	}
	catch(Exception e)
	{
		writefln("error: %s",e.to!string);
	}
	return files;
}
string[] findAttributes(hid_t obj_id)
{
    hsize_t idx=0;
    string[] ret;
    H5A.iterate2(obj_id, H5Index.name, H5IterOrder.inc,  &idx, &myAttributeIterator, &ret);
    return ret;
}

extern(C) herr_t  myAttributeIterator( hid_t location_id/*in*/, const char *attr_name/*in*/, const H5A_info_t *ainfo/*in*/, void *op_data/*in,out*/)
{
    auto attrib=cast(string[]*)op_data;
    (*attrib)~=ZtoString(attr_name);    
    return 0;
} 

string[] findLinks(hid_t group_id)
{
    hsize_t idx=0;
    string[] ret;
    H5L.iterate(group_id, H5Index.name, H5IterOrder.inc,  &idx, &myLinkIterator, &ret);
    return ret;
}

extern(C) herr_t  myLinkIterator( hid_t g_id/*in*/, const char *name/*in*/, const H5LInfo* info/*in*/, void *op_data/*in,out*/)
{
    auto linkstore=cast(string[]*)op_data;
    (*linkstore)~=ZtoString(name);    
    return 0;
} 


string[] dataSpaceContents(ubyte[] buf, hid_t type_id,hid_t space_id)
{
    hsize_t idx=0;
    dataSpaceDescriptor[] ret;
    string[] rets;
    H5D.iterate(cast(void*)buf,type_id,space_id,&dataSpaceIterator,cast(void*)ret.ptr);
    foreach(item;ret)
    {
        rets~=to!string(item.elemtype) ~ " " ~ to!string(item.ndim) ~ " " ~ to!string(item.point);
    }
    return rets;
}

struct dataSpaceDescriptor
{
    hid_t elemtype;
    uint ndim;
    hsize_t point;
}

extern(C) herr_t  dataSpaceIterator(void* elem, hid_t type_id, uint ndim, const hsize_t *point, void *op_data) 
{
    auto store=cast(dataSpaceDescriptor[]*)op_data;
    dataSpaceDescriptor ret_elem;
    ret_elem.elemtype=type_id;
    ret_elem.ndim=ndim;
    ret_elem.point=*point;
    (*store)~=ret_elem;
    return 0;
} 

string[] propertyList(hid_t id) 
{
    int idx=0;
    string[] ret;
    H5P.iterate(id, &idx, &myPropertyIterator, &ret);
    return ret;
}

extern(C) herr_t myPropertyIterator( hid_t id, const char *name, void *op_data )
{
    auto namestore=cast(string[]*)op_data;
    (*namestore)~=ZtoString(name);    
    return 0;
} 

string[] objectList(hid_t id)
{
    hsize_t idx=0;
    string[] ret;
    H5O.visit( id, H5Index.name, H5IterOrder.inc,&myObjectIterator,&ret );
    return ret;
}

extern(C) herr_t  myObjectIterator( hid_t g_id/*in*/, const char *name/*in*/, const H5OInfo* info/*in*/, void *op_data/*in,out*/)
{
    auto linkstore=cast(string[]*)op_data;
    (*linkstore)~=ZtoString(name);    
    return 0;
} 

void createGroup(string filename,string groupname)
{
  auto file=H5F.open(filename,H5F_ACC_RDWR, H5P_DEFAULT);
  auto group=H5G.create2(file,groupname, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
  H5G.close(group);
  H5F.close(file);
}

ubyte[] getUserBlock(string filename)
{
  ubyte[] buf;
  auto usize=getUserBlockSize(filename);
  buf.length=cast(size_t) usize;
  auto f=File(filename,"rb+");
  f.rewind();
  auto numbytes=f.rawRead(buf);
  buf.length=numbytes.length;
  f.close();
  return buf;
}


hid_t h5CreateWithUserBlock(string filename, hsize_t userBlockSize, bool truncateNotThrow )
{
  import std.file:exists;
  if ((!truncateNotThrow)&&exists(filename))
    throw new Exception("friendlyH5Create: attempt to create file that already exists: "~filename);
  userBlockSize=computeUserBlockSize(userBlockSize);
  debug writefln("%s userblock size",userBlockSize);
  auto plist = H5P.create(H5P_DEFAULT); //H5P_FILE_CREATE);
  H5P.set_userblock(plist, userBlockSize) ;
  //auto file_id = H5F.create(filename, H5F_ACC_TRUNC, plist, H5P_DEFAULT);
  auto file_id = H5F.create(filename, H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);
  H5P.close(plist);
  return file_id;
}

void setUserBlock(string filename, ubyte[] buf)
{
  auto usize=getUserBlockSize(filename);
  if (usize<buf.length)
    throw new Exception("Attempted to set user block for file: "~ filename~ " but user block is only "~
      to!string(usize) ~ " bytes long and buffer is "~to!string(buf.length)~" bytes long");
  auto f=File(filename,"wb+");
  f.rewind();
  f.rawWrite(buf);
  f.flush();
  f.close();
}

/**
  Function: compute_user_block_size
    Purpose:  Find the offset of the HDF5 header after the user block:
        align at 0, 512, 1024, etc.
        ublock_size: the size of the user block (bytes).
 
     Return:  Success:    the location of the header == the size of the
        padded user block.
    Failure:      none
 
    Return:   Success:    last byte written in the output.
    Failure:    Exits program with EXIT_FAILURE value.
 */

hsize_t computeUserBlockSize (hsize_t ublock_size)
{
  hsize_t where = 512;
  if (ublock_size == 0)
    return 0;
  while (where < ublock_size)
    where *= 2;
  return (where);
}



hsize_t getUserBlockSize(string filename)
{
  import std.exception:enforce;
  hsize_t usize;
  auto testval = H5F.is_hdf5(filename);
  enforce(testval>0, new Exception("Input HDF5 file is not HDF: "~filename));
  auto ifile = H5F.open (filename, H5F_ACC_RDONLY, H5P_DEFAULT);
  enforce(ifile>=0, new Exception("Cannot open input HDF5 file: "~filename));
  auto  plist = H5F.get_create_plist (ifile);
  enforce(plist>=0, new Exception("Cannot get file creation plist for file "~filename));
  H5P.get_userblock (plist, &usize);
  H5P.close (plist);
  H5F.close (ifile);
  return usize;
}


bool dataSetExists(string filename, string datasetName)
{
  import std.file:exists;
  bool ret=false;
  if (exists(filename))
  {
    auto file=H5F.open(filename,H5F_ACC_RDWR, H5P_DEFAULT);
    ret=(H5L.exists(file,datasetName,H5P_DEFAULT)!=0)?true:false;
    H5F.close(file);
  }
  return ret;
}

string[] contentsOfHDF5(string filename)
{
  string[] ret;
  auto file=H5F.open(filename,H5F_ACC_RDWR, H5P_DEFAULT);
  ret= cast(string[])objectList(file);
  H5F.close(file);
  return ret;
}

hid_t mapDtoHDF5Type(string dType)
{
  switch(dType)
  {
    case "int":
      return H5T_NATIVE_INT;
    case "long":
      return H5T_NATIVE_LLONG;
    case "ubyte":
      return H5T_NATIVE_UCHAR;
    case "char":
      return H5T_NATIVE_SCHAR;
    case "ushort":
      return H5T_NATIVE_USHORT;
    case "short":
      return H5T_NATIVE_SHORT;
    case "float":
      return H5T_NATIVE_FLOAT;
    case "double":
      return H5T_NATIVE_DOUBLE;
    default:
      throw new Exception("unknown type: "~ dType);
  }
}

enum DumpMode
{
  unlink,
  truncate,
  append,
}

hid_t openFile(string fn)
{
  hid_t file; 
  import std.file:exists;
  if (exists(fn))
  {
    file=H5F.open(fn,H5F_ACC_RDWR, H5P_DEFAULT);
  }
  else
  {
    file = H5Fcreate(toStringz(fn), H5F_ACC_EXCL, H5P_DEFAULT, H5P_DEFAULT); // H5F.create(fn, H5F_ACC_TRUNC , H5P_DEFAULT, H5P_DEFAULT);
  }

  return file;
}


struct H5File
{
  string filename;
  hid_t file;

  this(string filename)
  {
    this.filename=filename;
    this.file=H5F.open(filename,H5F_ACC_RDWR, H5P_DEFAULT);
  }
  ~this()
  {
    H5F.close(file);
  }

  H5Group openGroup(string groupName)
  {
    return H5Group(this,groupName);
  }
}

struct H5Group
{
  bool isOpen=false;
  string name;
  hid_t group;

  this(H5File file, string groupName)
  {
    if(groupName.length!=0)
    {
      this.group=H5G.open2(file.file, groupName, H5P_DEFAULT);
      this.isOpen=true;
    }
    else
      this.group=file.file;
  }
  ~this()
  {
    if(isOpen)
      H5G.close(group);
  }
}
