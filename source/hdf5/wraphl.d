module hdf5.wraphl;


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;

        template __from(string moduleName) {
            mixin("import from = " ~ moduleName ~ ";");
        }
        struct DppOffsetSize{ long offset; long size; }
        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }


alias _Bool = bool;
struct dpp {

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }

    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias wchar_t = int;
    alias size_t = c_ulong;
    alias ptrdiff_t = c_long;
    struct max_align_t
    {
        @DppOffsetSize(0,8) long __clang_max_align_nonce1;
        @DppOffsetSize(16,16) real __clang_max_align_nonce2;
    }
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias ssize_t = c_long;
    alias id_t = uint;
    alias pid_t = int;
    alias off_t = c_long;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias gid_t = uint;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    alias fd_mask = c_long;
    struct fd_set
    {
        @DppOffsetSize(0,128) c_long[16] __fds_bits;
    }
    alias __fd_mask = c_long;
    alias suseconds_t = c_long;
    int __overflow(_IO_FILE*, int) @nogc nothrow;
    int __uflow(_IO_FILE*) @nogc nothrow;
    void funlockfile(_IO_FILE*) @nogc nothrow;
    int ftrylockfile(_IO_FILE*) @nogc nothrow;
    void flockfile(_IO_FILE*) @nogc nothrow;
    char* ctermid(char*) @nogc nothrow;
    int pclose(_IO_FILE*) @nogc nothrow;
    _IO_FILE* popen(const(char)*, const(char)*) @nogc nothrow;
    int fileno_unlocked(_IO_FILE*) @nogc nothrow;
    int fileno(_IO_FILE*) @nogc nothrow;
    void perror(const(char)*) @nogc nothrow;
    int ferror_unlocked(_IO_FILE*) @nogc nothrow;
    int feof_unlocked(_IO_FILE*) @nogc nothrow;
    void clearerr_unlocked(_IO_FILE*) @nogc nothrow;
    int ferror(_IO_FILE*) @nogc nothrow;
    int feof(_IO_FILE*) @nogc nothrow;
    void clearerr(_IO_FILE*) @nogc nothrow;
    int fsetpos(_IO_FILE*, const(_G_fpos_t)*) @nogc nothrow;
    int fgetpos(_IO_FILE*, _G_fpos_t*) @nogc nothrow;
    c_long ftello(_IO_FILE*) @nogc nothrow;
    int fseeko(_IO_FILE*, c_long, int) @nogc nothrow;
    void rewind(_IO_FILE*) @nogc nothrow;
    c_long ftell(_IO_FILE*) @nogc nothrow;
    int fseek(_IO_FILE*, c_long, int) @nogc nothrow;
    c_ulong fwrite_unlocked(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread_unlocked(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fwrite(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    int ungetc(int, _IO_FILE*) @nogc nothrow;
    int puts(const(char)*) @nogc nothrow;
    int fputs(const(char)*, _IO_FILE*) @nogc nothrow;
    c_long getline(char**, c_ulong*, _IO_FILE*) @nogc nothrow;
    c_long getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    c_long __getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    char* fgets(char*, int, _IO_FILE*) @nogc nothrow;
    int putw(int, _IO_FILE*) @nogc nothrow;
    int getw(_IO_FILE*) @nogc nothrow;
    int putchar_unlocked(int) @nogc nothrow;
    int putc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int fputc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int putchar(int) @nogc nothrow;
    int putc(int, _IO_FILE*) @nogc nothrow;
    int fputc(int, _IO_FILE*) @nogc nothrow;
    int fgetc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar_unlocked() @nogc nothrow;
    int getc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar() @nogc nothrow;
    int getc(_IO_FILE*) @nogc nothrow;
    int fgetc(_IO_FILE*) @nogc nothrow;
    int vsscanf(const(char)*, const(char)*, va_list*) @nogc nothrow;
    int vscanf(const(char)*, va_list*) @nogc nothrow;
    int vfscanf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    int sscanf(const(char)*, const(char)*, ...) @nogc nothrow;
    int scanf(const(char)*, ...) @nogc nothrow;
    int fscanf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    int dprintf(int, const(char)*, ...) @nogc nothrow;
    int vdprintf(int, const(char)*, va_list*) @nogc nothrow;
    int vsnprintf(char*, c_ulong, const(char)*, va_list*) @nogc nothrow;
    int snprintf(char*, c_ulong, const(char)*, ...) @nogc nothrow;
    int vsprintf(char*, const(char)*, va_list*) @nogc nothrow;
    int vprintf(const(char)*, va_list*) @nogc nothrow;
    int vfprintf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    int sprintf(char*, const(char)*, ...) @nogc nothrow;
    int printf(const(char)*, ...) @nogc nothrow;
    int fprintf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    void setlinebuf(_IO_FILE*) @nogc nothrow;
    void setbuffer(_IO_FILE*, char*, c_ulong) @nogc nothrow;
    int setvbuf(_IO_FILE*, char*, int, c_ulong) @nogc nothrow;
    void setbuf(_IO_FILE*, char*) @nogc nothrow;
    _IO_FILE* open_memstream(char**, c_ulong*) @nogc nothrow;
    _IO_FILE* fmemopen(void*, c_ulong, const(char)*) @nogc nothrow;
    struct H5AC_cache_config_t
    {
        @DppOffsetSize(0,4) int version_;
        @DppOffsetSize(4,1) bool rpt_fcn_enabled;
        @DppOffsetSize(5,1) bool open_trace_file;
        @DppOffsetSize(6,1) bool close_trace_file;
        @DppOffsetSize(7,1025) char[1025] trace_file_name;
        @DppOffsetSize(1032,1) bool evictions_enabled;
        @DppOffsetSize(1033,1) bool set_initial_size;
        @DppOffsetSize(1040,8) c_ulong initial_size;
        @DppOffsetSize(1048,8) double min_clean_fraction;
        @DppOffsetSize(1056,8) c_ulong max_size;
        @DppOffsetSize(1064,8) c_ulong min_size;
        @DppOffsetSize(1072,8) c_long epoch_length;
        @DppOffsetSize(1080,4) H5C_cache_incr_mode incr_mode;
        @DppOffsetSize(1088,8) double lower_hr_threshold;
        @DppOffsetSize(1096,8) double increment;
        @DppOffsetSize(1104,1) bool apply_max_increment;
        @DppOffsetSize(1112,8) c_ulong max_increment;
        @DppOffsetSize(1120,4) H5C_cache_flash_incr_mode flash_incr_mode;
        @DppOffsetSize(1128,8) double flash_multiple;
        @DppOffsetSize(1136,8) double flash_threshold;
        @DppOffsetSize(1144,4) H5C_cache_decr_mode decr_mode;
        @DppOffsetSize(1152,8) double upper_hr_threshold;
        @DppOffsetSize(1160,8) double decrement;
        @DppOffsetSize(1168,1) bool apply_max_decrement;
        @DppOffsetSize(1176,8) c_ulong max_decrement;
        @DppOffsetSize(1184,4) int epochs_before_eviction;
        @DppOffsetSize(1188,1) bool apply_empty_reserve;
        @DppOffsetSize(1192,8) double empty_reserve;
        @DppOffsetSize(1200,8) c_ulong dirty_bytes_threshold;
        @DppOffsetSize(1208,4) int metadata_write_strategy;
    }
    _IO_FILE* fdopen(int, const(char)*) @nogc nothrow;
    struct H5AC_cache_image_config_t
    {
        @DppOffsetSize(0,4) int version_;
        @DppOffsetSize(4,1) bool generate_image;
        @DppOffsetSize(5,1) bool save_resize_status;
        @DppOffsetSize(8,4) int entry_ageout;
    }
    struct H5A_info_t
    {
        @DppOffsetSize(0,1) bool corder_valid;
        @DppOffsetSize(4,4) uint corder;
        @DppOffsetSize(8,4) H5T_cset_t cset;
        @DppOffsetSize(16,8) ulong data_size;
    }
    alias H5A_operator2_t = int function(c_long, const(char)*, const(H5A_info_t)*, void*);
    c_long H5Acreate2(c_long, const(char)*, c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Acreate_by_name(c_long, const(char)*, const(char)*, c_long, c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Aopen(c_long, const(char)*, c_long) @nogc nothrow;
    c_long H5Aopen_by_name(c_long, const(char)*, const(char)*, c_long, c_long) @nogc nothrow;
    c_long H5Aopen_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, c_long, c_long) @nogc nothrow;
    int H5Awrite(c_long, c_long, const(void)*) @nogc nothrow;
    int H5Aread(c_long, c_long, void*) @nogc nothrow;
    int H5Aclose(c_long) @nogc nothrow;
    c_long H5Aget_space(c_long) @nogc nothrow;
    c_long H5Aget_type(c_long) @nogc nothrow;
    c_long H5Aget_create_plist(c_long) @nogc nothrow;
    c_long H5Aget_name(c_long, c_ulong, char*) @nogc nothrow;
    c_long H5Aget_name_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, char*, c_ulong, c_long) @nogc nothrow;
    ulong H5Aget_storage_size(c_long) @nogc nothrow;
    int H5Aget_info(c_long, H5A_info_t*) @nogc nothrow;
    int H5Aget_info_by_name(c_long, const(char)*, const(char)*, H5A_info_t*, c_long) @nogc nothrow;
    int H5Aget_info_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5A_info_t*, c_long) @nogc nothrow;
    int H5Arename(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5Arename_by_name(c_long, const(char)*, const(char)*, const(char)*, c_long) @nogc nothrow;
    int H5Aiterate2(c_long, H5_index_t, H5_iter_order_t, ulong*, int function(c_long, const(char)*, const(H5A_info_t)*, void*), void*) @nogc nothrow;
    int H5Aiterate_by_name(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong*, int function(c_long, const(char)*, const(H5A_info_t)*, void*), void*, c_long) @nogc nothrow;
    int H5Adelete(c_long, const(char)*) @nogc nothrow;
    int H5Adelete_by_name(c_long, const(char)*, const(char)*, c_long) @nogc nothrow;
    int H5Adelete_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, c_long) @nogc nothrow;
    int H5Aexists(c_long, const(char)*) @nogc nothrow;
    int H5Aexists_by_name(c_long, const(char)*, const(char)*, c_long) @nogc nothrow;
    alias H5A_operator1_t = int function(c_long, const(char)*, void*);
    c_long H5Acreate1(c_long, const(char)*, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Aopen_name(c_long, const(char)*) @nogc nothrow;
    c_long H5Aopen_idx(c_long, uint) @nogc nothrow;
    int H5Aget_num_attrs(c_long) @nogc nothrow;
    int H5Aiterate1(c_long, uint*, int function(c_long, const(char)*, void*), void*) @nogc nothrow;
    _IO_FILE* freopen(const(char)*, const(char)*, _IO_FILE*) @nogc nothrow;
    enum H5C_cache_incr_mode
    {
        H5C_incr__off = 0,
        H5C_incr__threshold = 1,
    }
    enum H5C_incr__off = H5C_cache_incr_mode.H5C_incr__off;
    enum H5C_incr__threshold = H5C_cache_incr_mode.H5C_incr__threshold;
    enum H5C_cache_flash_incr_mode
    {
        H5C_flash_incr__off = 0,
        H5C_flash_incr__add_space = 1,
    }
    enum H5C_flash_incr__off = H5C_cache_flash_incr_mode.H5C_flash_incr__off;
    enum H5C_flash_incr__add_space = H5C_cache_flash_incr_mode.H5C_flash_incr__add_space;
    enum H5C_cache_decr_mode
    {
        H5C_decr__off = 0,
        H5C_decr__threshold = 1,
        H5C_decr__age_out = 2,
        H5C_decr__age_out_with_threshold = 3,
    }
    enum H5C_decr__off = H5C_cache_decr_mode.H5C_decr__off;
    enum H5C_decr__threshold = H5C_cache_decr_mode.H5C_decr__threshold;
    enum H5C_decr__age_out = H5C_cache_decr_mode.H5C_decr__age_out;
    enum H5C_decr__age_out_with_threshold = H5C_cache_decr_mode.H5C_decr__age_out_with_threshold;
    int H5DOappend(c_long, c_long, uint, c_ulong, c_long, const(void)*) @nogc nothrow;
    int H5DOwrite_chunk(c_long, c_long, uint, const(ulong)*, c_ulong, const(void)*) @nogc nothrow;
    int H5DOread_chunk(c_long, c_long, const(ulong)*, uint*, void*) @nogc nothrow;
    _IO_FILE* fopen(const(char)*, const(char)*) @nogc nothrow;
    int fflush_unlocked(_IO_FILE*) @nogc nothrow;
    int fflush(_IO_FILE*) @nogc nothrow;
    int fclose(_IO_FILE*) @nogc nothrow;
    alias H5DS_iterate_t = int function(c_long, uint, c_long, void*);
    int H5DSattach_scale(c_long, c_long, uint) @nogc nothrow;
    int H5DSdetach_scale(c_long, c_long, uint) @nogc nothrow;
    int H5DSset_scale(c_long, const(char)*) @nogc nothrow;
    int H5DSget_num_scales(c_long, uint) @nogc nothrow;
    int H5DSset_label(c_long, uint, const(char)*) @nogc nothrow;
    c_long H5DSget_label(c_long, uint, char*, c_ulong) @nogc nothrow;
    c_long H5DSget_scale_name(c_long, char*, c_ulong) @nogc nothrow;
    int H5DSis_scale(c_long) @nogc nothrow;
    int H5DSiterate_scales(c_long, uint, int*, int function(c_long, uint, c_long, void*), void*) @nogc nothrow;
    int H5DSis_attached(c_long, c_long, uint) @nogc nothrow;
    char* tempnam(const(char)*, const(char)*) @nogc nothrow;
    enum H5D_layout_t
    {
        H5D_LAYOUT_ERROR = -1,
        H5D_COMPACT = 0,
        H5D_CONTIGUOUS = 1,
        H5D_CHUNKED = 2,
        H5D_VIRTUAL = 3,
        H5D_NLAYOUTS = 4,
    }
    enum H5D_LAYOUT_ERROR = H5D_layout_t.H5D_LAYOUT_ERROR;
    enum H5D_COMPACT = H5D_layout_t.H5D_COMPACT;
    enum H5D_CONTIGUOUS = H5D_layout_t.H5D_CONTIGUOUS;
    enum H5D_CHUNKED = H5D_layout_t.H5D_CHUNKED;
    enum H5D_VIRTUAL = H5D_layout_t.H5D_VIRTUAL;
    enum H5D_NLAYOUTS = H5D_layout_t.H5D_NLAYOUTS;
    enum H5D_chunk_index_t
    {
        H5D_CHUNK_IDX_BTREE = 0,
        H5D_CHUNK_IDX_SINGLE = 1,
        H5D_CHUNK_IDX_NONE = 2,
        H5D_CHUNK_IDX_FARRAY = 3,
        H5D_CHUNK_IDX_EARRAY = 4,
        H5D_CHUNK_IDX_BT2 = 5,
        H5D_CHUNK_IDX_NTYPES = 6,
    }
    enum H5D_CHUNK_IDX_BTREE = H5D_chunk_index_t.H5D_CHUNK_IDX_BTREE;
    enum H5D_CHUNK_IDX_SINGLE = H5D_chunk_index_t.H5D_CHUNK_IDX_SINGLE;
    enum H5D_CHUNK_IDX_NONE = H5D_chunk_index_t.H5D_CHUNK_IDX_NONE;
    enum H5D_CHUNK_IDX_FARRAY = H5D_chunk_index_t.H5D_CHUNK_IDX_FARRAY;
    enum H5D_CHUNK_IDX_EARRAY = H5D_chunk_index_t.H5D_CHUNK_IDX_EARRAY;
    enum H5D_CHUNK_IDX_BT2 = H5D_chunk_index_t.H5D_CHUNK_IDX_BT2;
    enum H5D_CHUNK_IDX_NTYPES = H5D_chunk_index_t.H5D_CHUNK_IDX_NTYPES;
    enum H5D_alloc_time_t
    {
        H5D_ALLOC_TIME_ERROR = -1,
        H5D_ALLOC_TIME_DEFAULT = 0,
        H5D_ALLOC_TIME_EARLY = 1,
        H5D_ALLOC_TIME_LATE = 2,
        H5D_ALLOC_TIME_INCR = 3,
    }
    enum H5D_ALLOC_TIME_ERROR = H5D_alloc_time_t.H5D_ALLOC_TIME_ERROR;
    enum H5D_ALLOC_TIME_DEFAULT = H5D_alloc_time_t.H5D_ALLOC_TIME_DEFAULT;
    enum H5D_ALLOC_TIME_EARLY = H5D_alloc_time_t.H5D_ALLOC_TIME_EARLY;
    enum H5D_ALLOC_TIME_LATE = H5D_alloc_time_t.H5D_ALLOC_TIME_LATE;
    enum H5D_ALLOC_TIME_INCR = H5D_alloc_time_t.H5D_ALLOC_TIME_INCR;
    enum H5D_space_status_t
    {
        H5D_SPACE_STATUS_ERROR = -1,
        H5D_SPACE_STATUS_NOT_ALLOCATED = 0,
        H5D_SPACE_STATUS_PART_ALLOCATED = 1,
        H5D_SPACE_STATUS_ALLOCATED = 2,
    }
    enum H5D_SPACE_STATUS_ERROR = H5D_space_status_t.H5D_SPACE_STATUS_ERROR;
    enum H5D_SPACE_STATUS_NOT_ALLOCATED = H5D_space_status_t.H5D_SPACE_STATUS_NOT_ALLOCATED;
    enum H5D_SPACE_STATUS_PART_ALLOCATED = H5D_space_status_t.H5D_SPACE_STATUS_PART_ALLOCATED;
    enum H5D_SPACE_STATUS_ALLOCATED = H5D_space_status_t.H5D_SPACE_STATUS_ALLOCATED;
    enum H5D_fill_time_t
    {
        H5D_FILL_TIME_ERROR = -1,
        H5D_FILL_TIME_ALLOC = 0,
        H5D_FILL_TIME_NEVER = 1,
        H5D_FILL_TIME_IFSET = 2,
    }
    enum H5D_FILL_TIME_ERROR = H5D_fill_time_t.H5D_FILL_TIME_ERROR;
    enum H5D_FILL_TIME_ALLOC = H5D_fill_time_t.H5D_FILL_TIME_ALLOC;
    enum H5D_FILL_TIME_NEVER = H5D_fill_time_t.H5D_FILL_TIME_NEVER;
    enum H5D_FILL_TIME_IFSET = H5D_fill_time_t.H5D_FILL_TIME_IFSET;
    enum H5D_fill_value_t
    {
        H5D_FILL_VALUE_ERROR = -1,
        H5D_FILL_VALUE_UNDEFINED = 0,
        H5D_FILL_VALUE_DEFAULT = 1,
        H5D_FILL_VALUE_USER_DEFINED = 2,
    }
    enum H5D_FILL_VALUE_ERROR = H5D_fill_value_t.H5D_FILL_VALUE_ERROR;
    enum H5D_FILL_VALUE_UNDEFINED = H5D_fill_value_t.H5D_FILL_VALUE_UNDEFINED;
    enum H5D_FILL_VALUE_DEFAULT = H5D_fill_value_t.H5D_FILL_VALUE_DEFAULT;
    enum H5D_FILL_VALUE_USER_DEFINED = H5D_fill_value_t.H5D_FILL_VALUE_USER_DEFINED;
    enum H5D_vds_view_t
    {
        H5D_VDS_ERROR = -1,
        H5D_VDS_FIRST_MISSING = 0,
        H5D_VDS_LAST_AVAILABLE = 1,
    }
    enum H5D_VDS_ERROR = H5D_vds_view_t.H5D_VDS_ERROR;
    enum H5D_VDS_FIRST_MISSING = H5D_vds_view_t.H5D_VDS_FIRST_MISSING;
    enum H5D_VDS_LAST_AVAILABLE = H5D_vds_view_t.H5D_VDS_LAST_AVAILABLE;
    alias H5D_append_cb_t = int function(c_long, ulong*, void*);
    alias H5D_operator_t = int function(void*, c_long, uint, const(ulong)*, void*);
    alias H5D_scatter_func_t = int function(const(void)**, c_ulong*, void*);
    alias H5D_gather_func_t = int function(const(void)*, c_ulong, void*);
    c_long H5Dcreate2(c_long, const(char)*, c_long, c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Dcreate_anon(c_long, c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Dopen2(c_long, const(char)*, c_long) @nogc nothrow;
    int H5Dclose(c_long) @nogc nothrow;
    c_long H5Dget_space(c_long) @nogc nothrow;
    int H5Dget_space_status(c_long, H5D_space_status_t*) @nogc nothrow;
    c_long H5Dget_type(c_long) @nogc nothrow;
    c_long H5Dget_create_plist(c_long) @nogc nothrow;
    c_long H5Dget_access_plist(c_long) @nogc nothrow;
    ulong H5Dget_storage_size(c_long) @nogc nothrow;
    int H5Dget_chunk_storage_size(c_long, const(ulong)*, ulong*) @nogc nothrow;
    int H5Dget_num_chunks(c_long, c_long, ulong*) @nogc nothrow;
    int H5Dget_chunk_info_by_coord(c_long, const(ulong)*, uint*, c_ulong*, ulong*) @nogc nothrow;
    int H5Dget_chunk_info(c_long, c_long, ulong, ulong*, uint*, c_ulong*, ulong*) @nogc nothrow;
    c_ulong H5Dget_offset(c_long) @nogc nothrow;
    int H5Dread(c_long, c_long, c_long, c_long, c_long, void*) @nogc nothrow;
    int H5Dwrite(c_long, c_long, c_long, c_long, c_long, const(void)*) @nogc nothrow;
    int H5Dwrite_chunk(c_long, c_long, uint, const(ulong)*, c_ulong, const(void)*) @nogc nothrow;
    int H5Dread_chunk(c_long, c_long, const(ulong)*, uint*, void*) @nogc nothrow;
    int H5Diterate(void*, c_long, c_long, int function(void*, c_long, uint, const(ulong)*, void*), void*) @nogc nothrow;
    int H5Dvlen_reclaim(c_long, c_long, c_long, void*) @nogc nothrow;
    int H5Dvlen_get_buf_size(c_long, c_long, c_long, ulong*) @nogc nothrow;
    int H5Dfill(const(void)*, c_long, void*, c_long, c_long) @nogc nothrow;
    int H5Dset_extent(c_long, const(ulong)*) @nogc nothrow;
    int H5Dflush(c_long) @nogc nothrow;
    int H5Drefresh(c_long) @nogc nothrow;
    int H5Dscatter(int function(const(void)**, c_ulong*, void*), void*, c_long, c_long, void*) @nogc nothrow;
    int H5Dgather(c_long, const(void)*, c_long, c_ulong, void*, int function(const(void)*, c_ulong, void*), void*) @nogc nothrow;
    int H5Ddebug(c_long) @nogc nothrow;
    int H5Dformat_convert(c_long) @nogc nothrow;
    int H5Dget_chunk_index_type(c_long, H5D_chunk_index_t*) @nogc nothrow;
    char* tmpnam_r(char*) @nogc nothrow;
    char* tmpnam(char*) @nogc nothrow;
    c_long H5Dcreate1(c_long, const(char)*, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Dopen1(c_long, const(char)*) @nogc nothrow;
    int H5Dextend(c_long, const(ulong)*) @nogc nothrow;
    _IO_FILE* tmpfile() @nogc nothrow;
    int renameat(int, const(char)*, int, const(char)*) @nogc nothrow;
    int rename(const(char)*, const(char)*) @nogc nothrow;
    int remove(const(char)*) @nogc nothrow;
    extern __gshared _IO_FILE* stderr;
    extern __gshared _IO_FILE* stdout;
    extern __gshared _IO_FILE* stdin;
    alias fpos_t = _G_fpos_t;
    extern __gshared c_long H5E_ATOM_g;
    extern __gshared c_long H5E_FILE_g;
    extern __gshared c_long H5E_PLUGIN_g;
    extern __gshared c_long H5E_ERROR_g;
    extern __gshared c_long H5E_PLIST_g;
    extern __gshared c_long H5E_SYM_g;
    extern __gshared c_long H5E_SLIST_g;
    extern __gshared c_long H5E_PLINE_g;
    extern __gshared c_long H5E_RS_g;
    extern __gshared c_long H5E_HEAP_g;
    extern __gshared c_long H5E_VFL_g;
    extern __gshared c_long H5E_IO_g;
    extern __gshared c_long H5E_EFL_g;
    extern __gshared c_long H5E_CACHE_g;
    extern __gshared c_long H5E_TST_g;
    extern __gshared c_long H5E_ATTR_g;
    extern __gshared c_long H5E_CONTEXT_g;
    extern __gshared c_long H5E_ARGS_g;
    extern __gshared c_long H5E_BTREE_g;
    extern __gshared c_long H5E_SOHM_g;
    extern __gshared c_long H5E_LINK_g;
    extern __gshared c_long H5E_OHDR_g;
    extern __gshared c_long H5E_FSPACE_g;
    extern __gshared c_long H5E_RESOURCE_g;
    extern __gshared c_long H5E_FARRAY_g;
    extern __gshared c_long H5E_REFERENCE_g;
    extern __gshared c_long H5E_DATASET_g;
    extern __gshared c_long H5E_NONE_MAJOR_g;
    extern __gshared c_long H5E_STORAGE_g;
    extern __gshared c_long H5E_EARRAY_g;
    extern __gshared c_long H5E_FUNC_g;
    extern __gshared c_long H5E_INTERNAL_g;
    extern __gshared c_long H5E_DATASPACE_g;
    extern __gshared c_long H5E_PAGEBUF_g;
    extern __gshared c_long H5E_DATATYPE_g;
    alias uintmax_t = c_ulong;
    alias intmax_t = c_long;
    extern __gshared c_long H5E_CANTCLIP_g;
    extern __gshared c_long H5E_CANTCOUNT_g;
    extern __gshared c_long H5E_CANTSELECT_g;
    extern __gshared c_long H5E_CANTNEXT_g;
    extern __gshared c_long H5E_BADSELECT_g;
    extern __gshared c_long H5E_CANTCOMPARE_g;
    extern __gshared c_long H5E_CANTAPPEND_g;
    alias uintptr_t = c_ulong;
    alias intptr_t = c_long;
    alias uint_fast64_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    extern __gshared c_long H5E_MPI_g;
    extern __gshared c_long H5E_MPIERRSTR_g;
    extern __gshared c_long H5E_CANTRECV_g;
    extern __gshared c_long H5E_CANTGATHER_g;
    extern __gshared c_long H5E_NO_INDEPENDENT_g;
    alias uint_fast16_t = c_ulong;
    alias uint_fast8_t = ubyte;
    alias int_fast64_t = c_long;
    extern __gshared c_long H5E_CANTGET_g;
    extern __gshared c_long H5E_CANTSET_g;
    extern __gshared c_long H5E_DUPCLASS_g;
    extern __gshared c_long H5E_SETDISALLOWED_g;
    alias int_fast32_t = c_long;
    extern __gshared c_long H5E_OPENERROR_g;
    alias int_fast16_t = c_long;
    alias int_fast8_t = byte;
    alias uint_least64_t = c_ulong;
    alias uint_least32_t = uint;
    alias uint_least16_t = ushort;
    alias uint_least8_t = ubyte;
    alias int_least64_t = c_long;
    alias int_least32_t = int;
    alias int_least16_t = short;
    alias int_least8_t = byte;
    extern __gshared c_long H5E_CANTFLUSH_g;
    extern __gshared c_long H5E_CANTUNSERIALIZE_g;
    extern __gshared c_long H5E_CANTSERIALIZE_g;
    extern __gshared c_long H5E_CANTTAG_g;
    extern __gshared c_long H5E_CANTLOAD_g;
    extern __gshared c_long H5E_PROTECT_g;
    extern __gshared c_long H5E_NOTCACHED_g;
    extern __gshared c_long H5E_SYSTEM_g;
    extern __gshared c_long H5E_CANTINS_g;
    extern __gshared c_long H5E_CANTPROTECT_g;
    extern __gshared c_long H5E_CANTUNPROTECT_g;
    extern __gshared c_long H5E_CANTPIN_g;
    extern __gshared c_long H5E_CANTUNPIN_g;
    extern __gshared c_long H5E_CANTMARKDIRTY_g;
    extern __gshared c_long H5E_CANTMARKCLEAN_g;
    extern __gshared c_long H5E_CANTMARKUNSERIALIZED_g;
    extern __gshared c_long H5E_CANTMARKSERIALIZED_g;
    extern __gshared c_long H5E_CANTDIRTY_g;
    extern __gshared c_long H5E_CANTCLEAN_g;
    extern __gshared c_long H5E_CANTEXPUNGE_g;
    extern __gshared c_long H5E_CANTRESIZE_g;
    extern __gshared c_long H5E_CANTDEPEND_g;
    extern __gshared c_long H5E_CANTUNDEPEND_g;
    extern __gshared c_long H5E_CANTNOTIFY_g;
    extern __gshared c_long H5E_LOGGING_g;
    extern __gshared c_long H5E_LOGFAIL_g;
    extern __gshared c_long H5E_CANTCORK_g;
    extern __gshared c_long H5E_CANTUNCORK_g;
    c_ulong wcstoumax(const(int)*, int**, int) @nogc nothrow;
    c_long wcstoimax(const(int)*, int**, int) @nogc nothrow;
    extern __gshared c_long H5E_BADATOM_g;
    extern __gshared c_long H5E_BADGROUP_g;
    extern __gshared c_long H5E_CANTREGISTER_g;
    extern __gshared c_long H5E_CANTINC_g;
    extern __gshared c_long H5E_CANTDEC_g;
    extern __gshared c_long H5E_NOIDS_g;
    c_ulong strtoumax(const(char)*, char**, int) @nogc nothrow;
    extern __gshared c_long H5E_CANTCONVERT_g;
    extern __gshared c_long H5E_BADSIZE_g;
    c_long strtoimax(const(char)*, char**, int) @nogc nothrow;
    imaxdiv_t imaxdiv(c_long, c_long) @nogc nothrow;
    c_long imaxabs(c_long) @nogc nothrow;
    struct imaxdiv_t
    {
        @DppOffsetSize(0,8) c_long quot;
        @DppOffsetSize(8,8) c_long rem;
    }
    extern __gshared c_long H5E_NOSPACE_g;
    extern __gshared c_long H5E_CANTALLOC_g;
    extern __gshared c_long H5E_CANTCOPY_g;
    extern __gshared c_long H5E_CANTFREE_g;
    extern __gshared c_long H5E_ALREADYEXISTS_g;
    extern __gshared c_long H5E_CANTLOCK_g;
    extern __gshared c_long H5E_CANTUNLOCK_g;
    extern __gshared c_long H5E_CANTGC_g;
    extern __gshared c_long H5E_CANTGETSIZE_g;
    extern __gshared c_long H5E_OBJOPEN_g;
    extern __gshared c_long H5E_SYSERRSTR_g;
    alias __gwchar_t = int;
    extern __gshared c_long H5E_NOFILTER_g;
    extern __gshared c_long H5E_CALLBACK_g;
    extern __gshared c_long H5E_CANAPPLY_g;
    extern __gshared c_long H5E_SETLOCAL_g;
    extern __gshared c_long H5E_NOENCODER_g;
    extern __gshared c_long H5E_CANTFILTER_g;
    extern __gshared c_long H5E_UNINITIALIZED_g;
    extern __gshared c_long H5E_UNSUPPORTED_g;
    extern __gshared c_long H5E_BADTYPE_g;
    extern __gshared c_long H5E_BADRANGE_g;
    extern __gshared c_long H5E_BADVALUE_g;
    extern __gshared c_long H5E_CANTINIT_g;
    extern __gshared c_long H5E_ALREADYINIT_g;
    extern __gshared c_long H5E_CANTRELEASE_g;
    extern __gshared c_long H5E_SEEKERROR_g;
    extern __gshared c_long H5E_READERROR_g;
    extern __gshared c_long H5E_WRITEERROR_g;
    extern __gshared c_long H5E_CLOSEERROR_g;
    extern __gshared c_long H5E_OVERFLOW_g;
    extern __gshared c_long H5E_FCNTL_g;
    extern __gshared c_long H5E_NONE_MINOR_g;
    extern __gshared c_long H5E_TRAVERSE_g;
    extern __gshared c_long H5E_NLINKS_g;
    extern __gshared c_long H5E_NOTREGISTERED_g;
    extern __gshared c_long H5E_CANTMOVE_g;
    extern __gshared c_long H5E_CANTSORT_g;
    extern __gshared c_long H5E_LINKCOUNT_g;
    extern __gshared c_long H5E_VERSION_g;
    extern __gshared c_long H5E_ALIGNMENT_g;
    extern __gshared c_long H5E_BADMESG_g;
    extern __gshared c_long H5E_CANTDELETE_g;
    extern __gshared c_long H5E_BADITER_g;
    extern __gshared c_long H5E_CANTPACK_g;
    extern __gshared c_long H5E_CANTRESET_g;
    extern __gshared c_long H5E_CANTRENAME_g;
    extern __gshared c_long H5E_NOTFOUND_g;
    extern __gshared c_long H5E_EXISTS_g;
    extern __gshared c_long H5E_CANTENCODE_g;
    extern __gshared c_long H5E_CANTDECODE_g;
    extern __gshared c_long H5E_CANTSPLIT_g;
    extern __gshared c_long H5E_CANTREDISTRIBUTE_g;
    extern __gshared c_long H5E_CANTSWAP_g;
    extern __gshared c_long H5E_CANTINSERT_g;
    extern __gshared c_long H5E_CANTLIST_g;
    extern __gshared c_long H5E_CANTMODIFY_g;
    extern __gshared c_long H5E_CANTREMOVE_g;
    extern __gshared c_long H5E_FILEEXISTS_g;
    extern __gshared c_long H5E_FILEOPEN_g;
    extern __gshared c_long H5E_CANTCREATE_g;
    extern __gshared c_long H5E_CANTOPENFILE_g;
    extern __gshared c_long H5E_CANTCLOSEFILE_g;
    extern __gshared c_long H5E_NOTHDF5_g;
    extern __gshared c_long H5E_BADFILE_g;
    extern __gshared c_long H5E_TRUNCATED_g;
    extern __gshared c_long H5E_MOUNT_g;
    extern __gshared c_long H5E_CANTRESTORE_g;
    extern __gshared c_long H5E_CANTCOMPUTE_g;
    extern __gshared c_long H5E_CANTEXTEND_g;
    extern __gshared c_long H5E_CANTATTACH_g;
    extern __gshared c_long H5E_CANTUPDATE_g;
    extern __gshared c_long H5E_CANTOPERATE_g;
    extern __gshared c_long H5E_CANTMERGE_g;
    extern __gshared c_long H5E_CANTREVIVE_g;
    extern __gshared c_long H5E_CANTSHRINK_g;
    extern __gshared c_long H5E_CANTOPENOBJ_g;
    extern __gshared c_long H5E_CANTCLOSEOBJ_g;
    extern __gshared c_long H5E_COMPLEN_g;
    extern __gshared c_long H5E_PATH_g;
    enum H5E_type_t
    {
        H5E_MAJOR = 0,
        H5E_MINOR = 1,
    }
    enum H5E_MAJOR = H5E_type_t.H5E_MAJOR;
    enum H5E_MINOR = H5E_type_t.H5E_MINOR;
    struct H5E_error2_t
    {
        @DppOffsetSize(0,8) c_long cls_id;
        @DppOffsetSize(8,8) c_long maj_num;
        @DppOffsetSize(16,8) c_long min_num;
        @DppOffsetSize(24,4) uint line;
        @DppOffsetSize(32,8) const(char)* func_name;
        @DppOffsetSize(40,8) const(char)* file_name;
        @DppOffsetSize(48,8) const(char)* desc;
    }
    extern __gshared c_long H5E_ERR_CLS_g;
    enum H5E_direction_t
    {
        H5E_WALK_UPWARD = 0,
        H5E_WALK_DOWNWARD = 1,
    }
    enum H5E_WALK_UPWARD = H5E_direction_t.H5E_WALK_UPWARD;
    enum H5E_WALK_DOWNWARD = H5E_direction_t.H5E_WALK_DOWNWARD;
    alias H5E_walk2_t = int function(uint, const(H5E_error2_t)*, void*);
    alias H5E_auto2_t = int function(c_long, void*);
    c_long H5Eregister_class(const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int H5Eunregister_class(c_long) @nogc nothrow;
    int H5Eclose_msg(c_long) @nogc nothrow;
    c_long H5Ecreate_msg(c_long, H5E_type_t, const(char)*) @nogc nothrow;
    c_long H5Ecreate_stack() @nogc nothrow;
    c_long H5Eget_current_stack() @nogc nothrow;
    int H5Eclose_stack(c_long) @nogc nothrow;
    c_long H5Eget_class_name(c_long, char*, c_ulong) @nogc nothrow;
    int H5Eset_current_stack(c_long) @nogc nothrow;
    int H5Epush2(c_long, const(char)*, const(char)*, uint, c_long, c_long, c_long, const(char)*, ...) @nogc nothrow;
    int H5Epop(c_long, c_ulong) @nogc nothrow;
    int H5Eprint2(c_long, _IO_FILE*) @nogc nothrow;
    int H5Ewalk2(c_long, H5E_direction_t, int function(uint, const(H5E_error2_t)*, void*), void*) @nogc nothrow;
    int H5Eget_auto2(c_long, int function(c_long, void*)*, void**) @nogc nothrow;
    int H5Eset_auto2(c_long, int function(c_long, void*), void*) @nogc nothrow;
    int H5Eclear2(c_long) @nogc nothrow;
    int H5Eauto_is_v2(c_long, uint*) @nogc nothrow;
    c_long H5Eget_msg(c_long, H5E_type_t*, char*, c_ulong) @nogc nothrow;
    c_long H5Eget_num(c_long) @nogc nothrow;
    alias H5E_major_t = c_long;
    alias H5E_minor_t = c_long;
    struct H5E_error1_t
    {
        @DppOffsetSize(0,8) c_long maj_num;
        @DppOffsetSize(8,8) c_long min_num;
        @DppOffsetSize(16,8) const(char)* func_name;
        @DppOffsetSize(24,8) const(char)* file_name;
        @DppOffsetSize(32,4) uint line;
        @DppOffsetSize(40,8) const(char)* desc;
    }
    alias H5E_walk1_t = int function(int, H5E_error1_t*, void*);
    alias H5E_auto1_t = int function(void*);
    int H5Eclear1() @nogc nothrow;
    int H5Eget_auto1(int function(void*)*, void**) @nogc nothrow;
    int H5Epush1(const(char)*, const(char)*, uint, c_long, c_long, const(char)*) @nogc nothrow;
    int H5Eprint1(_IO_FILE*) @nogc nothrow;
    int H5Eset_auto1(int function(void*), void*) @nogc nothrow;
    int H5Ewalk1(H5E_direction_t, int function(int, H5E_error1_t*, void*), void*) @nogc nothrow;
    char* H5Eget_major(c_long) @nogc nothrow;
    char* H5Eget_minor(c_long) @nogc nothrow;
    c_long H5FD_core_init() @nogc nothrow;
    int H5Pset_fapl_core(c_long, c_ulong, bool) @nogc nothrow;
    int H5Pget_fapl_core(c_long, c_ulong*, bool*) @nogc nothrow;
    c_long H5FD_family_init() @nogc nothrow;
    int H5Pset_fapl_family(c_long, ulong, c_long) @nogc nothrow;
    int H5Pget_fapl_family(c_long, ulong*, c_long*) @nogc nothrow;
    c_long H5FD_log_init() @nogc nothrow;
    int H5Pset_fapl_log(c_long, const(char)*, ulong, c_ulong) @nogc nothrow;
    enum H5FD_mpio_xfer_t
    {
        H5FD_MPIO_INDEPENDENT = 0,
        H5FD_MPIO_COLLECTIVE = 1,
    }
    enum H5FD_MPIO_INDEPENDENT = H5FD_mpio_xfer_t.H5FD_MPIO_INDEPENDENT;
    enum H5FD_MPIO_COLLECTIVE = H5FD_mpio_xfer_t.H5FD_MPIO_COLLECTIVE;
    enum H5FD_mpio_chunk_opt_t
    {
        H5FD_MPIO_CHUNK_DEFAULT = 0,
        H5FD_MPIO_CHUNK_ONE_IO = 1,
        H5FD_MPIO_CHUNK_MULTI_IO = 2,
    }
    enum H5FD_MPIO_CHUNK_DEFAULT = H5FD_mpio_chunk_opt_t.H5FD_MPIO_CHUNK_DEFAULT;
    enum H5FD_MPIO_CHUNK_ONE_IO = H5FD_mpio_chunk_opt_t.H5FD_MPIO_CHUNK_ONE_IO;
    enum H5FD_MPIO_CHUNK_MULTI_IO = H5FD_mpio_chunk_opt_t.H5FD_MPIO_CHUNK_MULTI_IO;
    enum H5FD_mpio_collective_opt_t
    {
        H5FD_MPIO_COLLECTIVE_IO = 0,
        H5FD_MPIO_INDIVIDUAL_IO = 1,
    }
    enum H5FD_MPIO_COLLECTIVE_IO = H5FD_mpio_collective_opt_t.H5FD_MPIO_COLLECTIVE_IO;
    enum H5FD_MPIO_INDIVIDUAL_IO = H5FD_mpio_collective_opt_t.H5FD_MPIO_INDIVIDUAL_IO;
    alias timer_t = void*;
    alias time_t = c_long;
    c_long H5FD_multi_init() @nogc nothrow;
    int H5Pset_fapl_multi(c_long, const(H5F_mem_t)*, const(c_long)*, const(const(char)*)*, const(c_ulong)*, bool) @nogc nothrow;
    int H5Pget_fapl_multi(c_long, H5F_mem_t*, c_long*, char**, c_ulong*, bool*) @nogc nothrow;
    int H5Pset_fapl_split(c_long, const(char)*, c_long, const(char)*, c_long) @nogc nothrow;
    struct timeval
    {
        @DppOffsetSize(0,8) c_long tv_sec;
        @DppOffsetSize(8,8) c_long tv_usec;
    }
    struct timespec
    {
        @DppOffsetSize(0,8) c_long tv_sec;
        @DppOffsetSize(8,8) c_long tv_nsec;
    }
    alias H5FD_mem_t = H5F_mem_t;
    alias _IO_lock_t = void;
    struct _IO_wide_data;
    struct _IO_codecvt;
    struct _IO_marker;
    alias sigset_t = __sigset_t;
    alias clockid_t = int;
    alias clock_t = c_long;
    struct __sigset_t
    {
        @DppOffsetSize(0,128) c_ulong[16] __val;
    }
    struct __mbstate_t
    {
        @DppOffsetSize(0,4) int __count;
        static union _Anonymous_0
        {
            @DppOffsetSize(0,4) uint __wch;
            @DppOffsetSize(0,4) char[4] __wchb;
        }
        @DppOffsetSize(4,4) _Anonymous_0 __value;
    }
    struct _G_fpos_t
    {
        @DppOffsetSize(0,8) c_long __pos;
        @DppOffsetSize(8,8) __mbstate_t __state;
    }
    alias __fpos_t = _G_fpos_t;
    struct _G_fpos64_t
    {
        @DppOffsetSize(0,8) c_long __pos;
        @DppOffsetSize(8,8) __mbstate_t __state;
    }
    alias __fpos64_t = _G_fpos64_t;
    alias __FILE = _IO_FILE;
    struct _IO_FILE
    {
        @DppOffsetSize(0,4) int _flags;
        @DppOffsetSize(8,8) char* _IO_read_ptr;
        @DppOffsetSize(16,8) char* _IO_read_end;
        @DppOffsetSize(24,8) char* _IO_read_base;
        @DppOffsetSize(32,8) char* _IO_write_base;
        @DppOffsetSize(40,8) char* _IO_write_ptr;
        @DppOffsetSize(48,8) char* _IO_write_end;
        @DppOffsetSize(56,8) char* _IO_buf_base;
        @DppOffsetSize(64,8) char* _IO_buf_end;
        @DppOffsetSize(72,8) char* _IO_save_base;
        @DppOffsetSize(80,8) char* _IO_backup_base;
        @DppOffsetSize(88,8) char* _IO_save_end;
        @DppOffsetSize(96,8) _IO_marker* _markers;
        @DppOffsetSize(104,8) _IO_FILE* _chain;
        @DppOffsetSize(112,4) int _fileno;
        @DppOffsetSize(116,4) int _flags2;
        @DppOffsetSize(120,8) c_long _old_offset;
        @DppOffsetSize(128,2) ushort _cur_column;
        @DppOffsetSize(130,1) byte _vtable_offset;
        @DppOffsetSize(131,1) char[1] _shortbuf;
        @DppOffsetSize(136,8) void* _lock;
        @DppOffsetSize(144,8) c_long _offset;
        @DppOffsetSize(152,8) _IO_codecvt* _codecvt;
        @DppOffsetSize(160,8) _IO_wide_data* _wide_data;
        @DppOffsetSize(168,8) _IO_FILE* _freeres_list;
        @DppOffsetSize(176,8) void* _freeres_buf;
        @DppOffsetSize(184,8) c_ulong __pad5;
        @DppOffsetSize(192,4) int _mode;
        @DppOffsetSize(196,20) char[20] _unused2;
    }
    alias FILE = _IO_FILE;
    alias __sig_atomic_t = int;
    alias __socklen_t = uint;
    struct H5FD_t
    {
        @DppOffsetSize(0,8) c_long driver_id;
        @DppOffsetSize(8,8) const(H5FD_class_t)* cls;
        @DppOffsetSize(16,8) c_ulong fileno;
        @DppOffsetSize(24,4) uint access_flags;
        @DppOffsetSize(32,8) c_ulong feature_flags;
        @DppOffsetSize(40,8) c_ulong maxaddr;
        @DppOffsetSize(48,8) c_ulong base_addr;
        @DppOffsetSize(56,8) ulong threshold;
        @DppOffsetSize(64,8) ulong alignment;
        @DppOffsetSize(72,1) bool paged_aggr;
    }
    struct H5FD_class_t
    {
        @DppOffsetSize(0,8) const(char)* name;
        @DppOffsetSize(8,8) c_ulong maxaddr;
        @DppOffsetSize(16,4) H5F_close_degree_t fc_degree;
        @DppOffsetSize(24,8) int function() terminate;
        @DppOffsetSize(32,8) ulong function(H5FD_t*) sb_size;
        @DppOffsetSize(40,8) int function(H5FD_t*, char*, ubyte*) sb_encode;
        @DppOffsetSize(48,8) int function(H5FD_t*, const(char)*, const(ubyte)*) sb_decode;
        @DppOffsetSize(56,8) c_ulong fapl_size;
        @DppOffsetSize(64,8) void* function(H5FD_t*) fapl_get;
        @DppOffsetSize(72,8) void* function(const(void)*) fapl_copy;
        @DppOffsetSize(80,8) int function(void*) fapl_free;
        @DppOffsetSize(88,8) c_ulong dxpl_size;
        @DppOffsetSize(96,8) void* function(const(void)*) dxpl_copy;
        @DppOffsetSize(104,8) int function(void*) dxpl_free;
        @DppOffsetSize(112,8) H5FD_t* function(const(char)*, uint, c_long, c_ulong) open;
        @DppOffsetSize(120,8) int function(H5FD_t*) close;
        @DppOffsetSize(128,8) int function(const(H5FD_t)*, const(H5FD_t)*) cmp;
        @DppOffsetSize(136,8) int function(const(H5FD_t)*, c_ulong*) query;
        @DppOffsetSize(144,8) int function(const(H5FD_t)*, H5F_mem_t*) get_type_map;
        @DppOffsetSize(152,8) c_ulong function(H5FD_t*, H5F_mem_t, c_long, ulong) alloc;
        @DppOffsetSize(160,8) int function(H5FD_t*, H5F_mem_t, c_long, c_ulong, ulong) free;
        @DppOffsetSize(168,8) c_ulong function(const(H5FD_t)*, H5F_mem_t) get_eoa;
        @DppOffsetSize(176,8) int function(H5FD_t*, H5F_mem_t, c_ulong) set_eoa;
        @DppOffsetSize(184,8) c_ulong function(const(H5FD_t)*, H5F_mem_t) get_eof;
        @DppOffsetSize(192,8) int function(H5FD_t*, c_long, void**) get_handle;
        @DppOffsetSize(200,8) int function(H5FD_t*, H5F_mem_t, c_long, c_ulong, c_ulong, void*) read;
        @DppOffsetSize(208,8) int function(H5FD_t*, H5F_mem_t, c_long, c_ulong, c_ulong, const(void)*) write;
        @DppOffsetSize(216,8) int function(H5FD_t*, c_long, bool) flush;
        @DppOffsetSize(224,8) int function(H5FD_t*, c_long, bool) truncate;
        @DppOffsetSize(232,8) int function(H5FD_t*, bool) lock;
        @DppOffsetSize(240,8) int function(H5FD_t*) unlock;
        @DppOffsetSize(248,28) H5F_mem_t[7] fl_map;
    }
    struct H5FD_free_t
    {
        @DppOffsetSize(0,8) c_ulong addr;
        @DppOffsetSize(8,8) ulong size;
        @DppOffsetSize(16,8) H5FD_free_t* next;
    }
    alias H5FD_file_image_op_t = _Anonymous_1;
    enum _Anonymous_1
    {
        H5FD_FILE_IMAGE_OP_NO_OP = 0,
        H5FD_FILE_IMAGE_OP_PROPERTY_LIST_SET = 1,
        H5FD_FILE_IMAGE_OP_PROPERTY_LIST_COPY = 2,
        H5FD_FILE_IMAGE_OP_PROPERTY_LIST_GET = 3,
        H5FD_FILE_IMAGE_OP_PROPERTY_LIST_CLOSE = 4,
        H5FD_FILE_IMAGE_OP_FILE_OPEN = 5,
        H5FD_FILE_IMAGE_OP_FILE_RESIZE = 6,
        H5FD_FILE_IMAGE_OP_FILE_CLOSE = 7,
    }
    enum H5FD_FILE_IMAGE_OP_NO_OP = _Anonymous_1.H5FD_FILE_IMAGE_OP_NO_OP;
    enum H5FD_FILE_IMAGE_OP_PROPERTY_LIST_SET = _Anonymous_1.H5FD_FILE_IMAGE_OP_PROPERTY_LIST_SET;
    enum H5FD_FILE_IMAGE_OP_PROPERTY_LIST_COPY = _Anonymous_1.H5FD_FILE_IMAGE_OP_PROPERTY_LIST_COPY;
    enum H5FD_FILE_IMAGE_OP_PROPERTY_LIST_GET = _Anonymous_1.H5FD_FILE_IMAGE_OP_PROPERTY_LIST_GET;
    enum H5FD_FILE_IMAGE_OP_PROPERTY_LIST_CLOSE = _Anonymous_1.H5FD_FILE_IMAGE_OP_PROPERTY_LIST_CLOSE;
    enum H5FD_FILE_IMAGE_OP_FILE_OPEN = _Anonymous_1.H5FD_FILE_IMAGE_OP_FILE_OPEN;
    enum H5FD_FILE_IMAGE_OP_FILE_RESIZE = _Anonymous_1.H5FD_FILE_IMAGE_OP_FILE_RESIZE;
    enum H5FD_FILE_IMAGE_OP_FILE_CLOSE = _Anonymous_1.H5FD_FILE_IMAGE_OP_FILE_CLOSE;
    struct H5FD_file_image_callbacks_t
    {
        @DppOffsetSize(0,8) void* function(c_ulong, H5FD_file_image_op_t, void*) image_malloc;
        @DppOffsetSize(8,8) void* function(void*, const(void)*, c_ulong, H5FD_file_image_op_t, void*) image_memcpy;
        @DppOffsetSize(16,8) void* function(void*, c_ulong, H5FD_file_image_op_t, void*) image_realloc;
        @DppOffsetSize(24,8) int function(void*, H5FD_file_image_op_t, void*) image_free;
        @DppOffsetSize(32,8) void* function(void*) udata_copy;
        @DppOffsetSize(40,8) int function(void*) udata_free;
        @DppOffsetSize(48,8) void* udata;
    }
    c_long H5FDregister(const(H5FD_class_t)*) @nogc nothrow;
    int H5FDunregister(c_long) @nogc nothrow;
    H5FD_t* H5FDopen(const(char)*, uint, c_long, c_ulong) @nogc nothrow;
    int H5FDclose(H5FD_t*) @nogc nothrow;
    int H5FDcmp(const(H5FD_t)*, const(H5FD_t)*) @nogc nothrow;
    int H5FDquery(const(H5FD_t)*, c_ulong*) @nogc nothrow;
    c_ulong H5FDalloc(H5FD_t*, H5F_mem_t, c_long, ulong) @nogc nothrow;
    int H5FDfree(H5FD_t*, H5F_mem_t, c_long, c_ulong, ulong) @nogc nothrow;
    c_ulong H5FDget_eoa(H5FD_t*, H5F_mem_t) @nogc nothrow;
    int H5FDset_eoa(H5FD_t*, H5F_mem_t, c_ulong) @nogc nothrow;
    c_ulong H5FDget_eof(H5FD_t*, H5F_mem_t) @nogc nothrow;
    int H5FDget_vfd_handle(H5FD_t*, c_long, void**) @nogc nothrow;
    int H5FDread(H5FD_t*, H5F_mem_t, c_long, c_ulong, c_ulong, void*) @nogc nothrow;
    int H5FDwrite(H5FD_t*, H5F_mem_t, c_long, c_ulong, c_ulong, const(void)*) @nogc nothrow;
    int H5FDflush(H5FD_t*, c_long, bool) @nogc nothrow;
    int H5FDtruncate(H5FD_t*, c_long, bool) @nogc nothrow;
    int H5FDlock(H5FD_t*, bool) @nogc nothrow;
    int H5FDunlock(H5FD_t*) @nogc nothrow;
    int H5FDdriver_query(c_long, c_ulong*) @nogc nothrow;
    alias __intptr_t = c_long;
    alias __caddr_t = char*;
    c_long H5FD_sec2_init() @nogc nothrow;
    int H5Pset_fapl_sec2(c_long) @nogc nothrow;
    alias __loff_t = c_long;
    c_long H5FD_stdio_init() @nogc nothrow;
    int H5Pset_fapl_stdio(c_long) @nogc nothrow;
    alias __syscall_ulong_t = c_ulong;
    alias __syscall_slong_t = c_long;
    alias __ssize_t = c_long;
    alias __fsword_t = c_long;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    enum H5F_scope_t
    {
        H5F_SCOPE_LOCAL = 0,
        H5F_SCOPE_GLOBAL = 1,
    }
    enum H5F_SCOPE_LOCAL = H5F_scope_t.H5F_SCOPE_LOCAL;
    enum H5F_SCOPE_GLOBAL = H5F_scope_t.H5F_SCOPE_GLOBAL;
    alias __fsblkcnt64_t = c_ulong;
    enum H5F_close_degree_t
    {
        H5F_CLOSE_DEFAULT = 0,
        H5F_CLOSE_WEAK = 1,
        H5F_CLOSE_SEMI = 2,
        H5F_CLOSE_STRONG = 3,
    }
    enum H5F_CLOSE_DEFAULT = H5F_close_degree_t.H5F_CLOSE_DEFAULT;
    enum H5F_CLOSE_WEAK = H5F_close_degree_t.H5F_CLOSE_WEAK;
    enum H5F_CLOSE_SEMI = H5F_close_degree_t.H5F_CLOSE_SEMI;
    enum H5F_CLOSE_STRONG = H5F_close_degree_t.H5F_CLOSE_STRONG;
    struct H5F_info2_t
    {
        static struct _Anonymous_2
        {
            @DppOffsetSize(0,4) uint version_;
            @DppOffsetSize(8,8) ulong super_size;
            @DppOffsetSize(16,8) ulong super_ext_size;
        }
        @DppOffsetSize(0,24) _Anonymous_2 super_;
        static struct _Anonymous_3
        {
            @DppOffsetSize(0,4) uint version_;
            @DppOffsetSize(8,8) ulong meta_size;
            @DppOffsetSize(16,8) ulong tot_space;
        }
        @DppOffsetSize(24,24) _Anonymous_3 free;
        static struct _Anonymous_4
        {
            @DppOffsetSize(0,4) uint version_;
            @DppOffsetSize(8,8) ulong hdr_size;
            @DppOffsetSize(16,16) H5_ih_info_t msgs_info;
        }
        @DppOffsetSize(48,32) _Anonymous_4 sohm;
    }
    enum H5F_mem_t
    {
        H5FD_MEM_NOLIST = -1,
        H5FD_MEM_DEFAULT = 0,
        H5FD_MEM_SUPER = 1,
        H5FD_MEM_BTREE = 2,
        H5FD_MEM_DRAW = 3,
        H5FD_MEM_GHEAP = 4,
        H5FD_MEM_LHEAP = 5,
        H5FD_MEM_OHDR = 6,
        H5FD_MEM_NTYPES = 7,
    }
    enum H5FD_MEM_NOLIST = H5F_mem_t.H5FD_MEM_NOLIST;
    enum H5FD_MEM_DEFAULT = H5F_mem_t.H5FD_MEM_DEFAULT;
    enum H5FD_MEM_SUPER = H5F_mem_t.H5FD_MEM_SUPER;
    enum H5FD_MEM_BTREE = H5F_mem_t.H5FD_MEM_BTREE;
    enum H5FD_MEM_DRAW = H5F_mem_t.H5FD_MEM_DRAW;
    enum H5FD_MEM_GHEAP = H5F_mem_t.H5FD_MEM_GHEAP;
    enum H5FD_MEM_LHEAP = H5F_mem_t.H5FD_MEM_LHEAP;
    enum H5FD_MEM_OHDR = H5F_mem_t.H5FD_MEM_OHDR;
    enum H5FD_MEM_NTYPES = H5F_mem_t.H5FD_MEM_NTYPES;
    struct H5F_sect_info_t
    {
        @DppOffsetSize(0,8) c_ulong addr;
        @DppOffsetSize(8,8) ulong size;
    }
    enum H5F_libver_t
    {
        H5F_LIBVER_ERROR = -1,
        H5F_LIBVER_EARLIEST = 0,
        H5F_LIBVER_V18 = 1,
        H5F_LIBVER_V110 = 2,
        H5F_LIBVER_NBOUNDS = 3,
    }
    enum H5F_LIBVER_ERROR = H5F_libver_t.H5F_LIBVER_ERROR;
    enum H5F_LIBVER_EARLIEST = H5F_libver_t.H5F_LIBVER_EARLIEST;
    enum H5F_LIBVER_V18 = H5F_libver_t.H5F_LIBVER_V18;
    enum H5F_LIBVER_V110 = H5F_libver_t.H5F_LIBVER_V110;
    enum H5F_LIBVER_NBOUNDS = H5F_libver_t.H5F_LIBVER_NBOUNDS;
    enum H5F_fspace_strategy_t
    {
        H5F_FSPACE_STRATEGY_FSM_AGGR = 0,
        H5F_FSPACE_STRATEGY_PAGE = 1,
        H5F_FSPACE_STRATEGY_AGGR = 2,
        H5F_FSPACE_STRATEGY_NONE = 3,
        H5F_FSPACE_STRATEGY_NTYPES = 4,
    }
    enum H5F_FSPACE_STRATEGY_FSM_AGGR = H5F_fspace_strategy_t.H5F_FSPACE_STRATEGY_FSM_AGGR;
    enum H5F_FSPACE_STRATEGY_PAGE = H5F_fspace_strategy_t.H5F_FSPACE_STRATEGY_PAGE;
    enum H5F_FSPACE_STRATEGY_AGGR = H5F_fspace_strategy_t.H5F_FSPACE_STRATEGY_AGGR;
    enum H5F_FSPACE_STRATEGY_NONE = H5F_fspace_strategy_t.H5F_FSPACE_STRATEGY_NONE;
    enum H5F_FSPACE_STRATEGY_NTYPES = H5F_fspace_strategy_t.H5F_FSPACE_STRATEGY_NTYPES;
    enum H5F_file_space_type_t
    {
        H5F_FILE_SPACE_DEFAULT = 0,
        H5F_FILE_SPACE_ALL_PERSIST = 1,
        H5F_FILE_SPACE_ALL = 2,
        H5F_FILE_SPACE_AGGR_VFD = 3,
        H5F_FILE_SPACE_VFD = 4,
        H5F_FILE_SPACE_NTYPES = 5,
    }
    enum H5F_FILE_SPACE_DEFAULT = H5F_file_space_type_t.H5F_FILE_SPACE_DEFAULT;
    enum H5F_FILE_SPACE_ALL_PERSIST = H5F_file_space_type_t.H5F_FILE_SPACE_ALL_PERSIST;
    enum H5F_FILE_SPACE_ALL = H5F_file_space_type_t.H5F_FILE_SPACE_ALL;
    enum H5F_FILE_SPACE_AGGR_VFD = H5F_file_space_type_t.H5F_FILE_SPACE_AGGR_VFD;
    enum H5F_FILE_SPACE_VFD = H5F_file_space_type_t.H5F_FILE_SPACE_VFD;
    enum H5F_FILE_SPACE_NTYPES = H5F_file_space_type_t.H5F_FILE_SPACE_NTYPES;
    struct H5F_retry_info_t
    {
        @DppOffsetSize(0,4) uint nbins;
        @DppOffsetSize(8,168) uint*[21] retries;
    }
    alias H5F_flush_cb_t = int function(c_long, void*);
    int H5Fis_hdf5(const(char)*) @nogc nothrow;
    c_long H5Fcreate(const(char)*, uint, c_long, c_long) @nogc nothrow;
    c_long H5Fopen(const(char)*, uint, c_long) @nogc nothrow;
    c_long H5Freopen(c_long) @nogc nothrow;
    int H5Fflush(c_long, H5F_scope_t) @nogc nothrow;
    int H5Fclose(c_long) @nogc nothrow;
    c_long H5Fget_create_plist(c_long) @nogc nothrow;
    c_long H5Fget_access_plist(c_long) @nogc nothrow;
    int H5Fget_intent(c_long, uint*) @nogc nothrow;
    c_long H5Fget_obj_count(c_long, uint) @nogc nothrow;
    c_long H5Fget_obj_ids(c_long, uint, c_ulong, c_long*) @nogc nothrow;
    int H5Fget_vfd_handle(c_long, c_long, void**) @nogc nothrow;
    int H5Fmount(c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Funmount(c_long, const(char)*) @nogc nothrow;
    long H5Fget_freespace(c_long) @nogc nothrow;
    int H5Fget_filesize(c_long, ulong*) @nogc nothrow;
    int H5Fget_eoa(c_long, c_ulong*) @nogc nothrow;
    int H5Fincrement_filesize(c_long, ulong) @nogc nothrow;
    c_long H5Fget_file_image(c_long, void*, c_ulong) @nogc nothrow;
    int H5Fget_mdc_config(c_long, H5AC_cache_config_t*) @nogc nothrow;
    int H5Fset_mdc_config(c_long, H5AC_cache_config_t*) @nogc nothrow;
    int H5Fget_mdc_hit_rate(c_long, double*) @nogc nothrow;
    int H5Fget_mdc_size(c_long, c_ulong*, c_ulong*, c_ulong*, int*) @nogc nothrow;
    int H5Freset_mdc_hit_rate_stats(c_long) @nogc nothrow;
    c_long H5Fget_name(c_long, char*, c_ulong) @nogc nothrow;
    int H5Fget_info2(c_long, H5F_info2_t*) @nogc nothrow;
    int H5Fget_metadata_read_retry_info(c_long, H5F_retry_info_t*) @nogc nothrow;
    int H5Fstart_swmr_write(c_long) @nogc nothrow;
    c_long H5Fget_free_sections(c_long, H5F_mem_t, c_ulong, H5F_sect_info_t*) @nogc nothrow;
    int H5Fclear_elink_file_cache(c_long) @nogc nothrow;
    int H5Fset_libver_bounds(c_long, H5F_libver_t, H5F_libver_t) @nogc nothrow;
    int H5Fstart_mdc_logging(c_long) @nogc nothrow;
    int H5Fstop_mdc_logging(c_long) @nogc nothrow;
    int H5Fget_mdc_logging_status(c_long, bool*, bool*) @nogc nothrow;
    int H5Fformat_convert(c_long) @nogc nothrow;
    int H5Freset_page_buffering_stats(c_long) @nogc nothrow;
    int H5Fget_page_buffering_stats(c_long, uint*, uint*, uint*, uint*, uint*) @nogc nothrow;
    int H5Fget_mdc_image_info(c_long, c_ulong*, ulong*) @nogc nothrow;
    int H5Fget_dset_no_attrs_hint(c_long, bool*) @nogc nothrow;
    int H5Fset_dset_no_attrs_hint(c_long, bool) @nogc nothrow;
    alias __fsblkcnt_t = c_ulong;
    struct H5F_info1_t
    {
        @DppOffsetSize(0,8) ulong super_ext_size;
        static struct _Anonymous_5
        {
            @DppOffsetSize(0,8) ulong hdr_size;
            @DppOffsetSize(8,16) H5_ih_info_t msgs_info;
        }
        @DppOffsetSize(8,24) _Anonymous_5 sohm;
    }
    int H5Fget_info1(c_long, H5F_info1_t*) @nogc nothrow;
    int H5Fset_latest_format(c_long, bool) @nogc nothrow;
    enum H5G_storage_type_t
    {
        H5G_STORAGE_TYPE_UNKNOWN = -1,
        H5G_STORAGE_TYPE_SYMBOL_TABLE = 0,
        H5G_STORAGE_TYPE_COMPACT = 1,
        H5G_STORAGE_TYPE_DENSE = 2,
    }
    enum H5G_STORAGE_TYPE_UNKNOWN = H5G_storage_type_t.H5G_STORAGE_TYPE_UNKNOWN;
    enum H5G_STORAGE_TYPE_SYMBOL_TABLE = H5G_storage_type_t.H5G_STORAGE_TYPE_SYMBOL_TABLE;
    enum H5G_STORAGE_TYPE_COMPACT = H5G_storage_type_t.H5G_STORAGE_TYPE_COMPACT;
    enum H5G_STORAGE_TYPE_DENSE = H5G_storage_type_t.H5G_STORAGE_TYPE_DENSE;
    struct H5G_info_t
    {
        @DppOffsetSize(0,4) H5G_storage_type_t storage_type;
        @DppOffsetSize(8,8) ulong nlinks;
        @DppOffsetSize(16,8) c_long max_corder;
        @DppOffsetSize(24,1) bool mounted;
    }
    c_long H5Gcreate2(c_long, const(char)*, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Gcreate_anon(c_long, c_long, c_long) @nogc nothrow;
    c_long H5Gopen2(c_long, const(char)*, c_long) @nogc nothrow;
    c_long H5Gget_create_plist(c_long) @nogc nothrow;
    int H5Gget_info(c_long, H5G_info_t*) @nogc nothrow;
    int H5Gget_info_by_name(c_long, const(char)*, H5G_info_t*, c_long) @nogc nothrow;
    int H5Gget_info_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5G_info_t*, c_long) @nogc nothrow;
    int H5Gclose(c_long) @nogc nothrow;
    int H5Gflush(c_long) @nogc nothrow;
    int H5Grefresh(c_long) @nogc nothrow;
    alias __blkcnt64_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blksize_t = c_long;
    enum H5G_obj_t
    {
        H5G_UNKNOWN = -1,
        H5G_GROUP = 0,
        H5G_DATASET = 1,
        H5G_TYPE = 2,
        H5G_LINK = 3,
        H5G_UDLINK = 4,
        H5G_RESERVED_5 = 5,
        H5G_RESERVED_6 = 6,
        H5G_RESERVED_7 = 7,
    }
    enum H5G_UNKNOWN = H5G_obj_t.H5G_UNKNOWN;
    enum H5G_GROUP = H5G_obj_t.H5G_GROUP;
    enum H5G_DATASET = H5G_obj_t.H5G_DATASET;
    enum H5G_TYPE = H5G_obj_t.H5G_TYPE;
    enum H5G_LINK = H5G_obj_t.H5G_LINK;
    enum H5G_UDLINK = H5G_obj_t.H5G_UDLINK;
    enum H5G_RESERVED_5 = H5G_obj_t.H5G_RESERVED_5;
    enum H5G_RESERVED_6 = H5G_obj_t.H5G_RESERVED_6;
    enum H5G_RESERVED_7 = H5G_obj_t.H5G_RESERVED_7;
    alias H5G_iterate_t = int function(c_long, const(char)*, void*);
    struct H5G_stat_t
    {
        @DppOffsetSize(0,16) c_ulong[2] fileno;
        @DppOffsetSize(16,16) c_ulong[2] objno;
        @DppOffsetSize(32,4) uint nlink;
        @DppOffsetSize(36,4) H5G_obj_t type;
        @DppOffsetSize(40,8) c_long mtime;
        @DppOffsetSize(48,8) c_ulong linklen;
        @DppOffsetSize(56,24) H5O_stat_t ohdr;
    }
    c_long H5Gcreate1(c_long, const(char)*, c_ulong) @nogc nothrow;
    c_long H5Gopen1(c_long, const(char)*) @nogc nothrow;
    int H5Glink(c_long, H5L_type_t, const(char)*, const(char)*) @nogc nothrow;
    int H5Glink2(c_long, const(char)*, H5L_type_t, c_long, const(char)*) @nogc nothrow;
    int H5Gmove(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5Gmove2(c_long, const(char)*, c_long, const(char)*) @nogc nothrow;
    int H5Gunlink(c_long, const(char)*) @nogc nothrow;
    int H5Gget_linkval(c_long, const(char)*, c_ulong, char*) @nogc nothrow;
    int H5Gset_comment(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5Gget_comment(c_long, const(char)*, c_ulong, char*) @nogc nothrow;
    int H5Giterate(c_long, const(char)*, int*, int function(c_long, const(char)*, void*), void*) @nogc nothrow;
    int H5Gget_num_objs(c_long, ulong*) @nogc nothrow;
    int H5Gget_objinfo(c_long, const(char)*, bool, H5G_stat_t*) @nogc nothrow;
    c_long H5Gget_objname_by_idx(c_long, ulong, char*, c_ulong) @nogc nothrow;
    H5G_obj_t H5Gget_objtype_by_idx(c_long, ulong) @nogc nothrow;
    alias __timer_t = void*;
    int H5IMmake_image_8bit(c_long, const(char)*, ulong, ulong, const(ubyte)*) @nogc nothrow;
    int H5IMmake_image_24bit(c_long, const(char)*, ulong, ulong, const(char)*, const(ubyte)*) @nogc nothrow;
    int H5IMget_image_info(c_long, const(char)*, ulong*, ulong*, ulong*, char*, long*) @nogc nothrow;
    int H5IMread_image(c_long, const(char)*, ubyte*) @nogc nothrow;
    int H5IMmake_palette(c_long, const(char)*, const(ulong)*, const(ubyte)*) @nogc nothrow;
    int H5IMlink_palette(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5IMunlink_palette(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5IMget_npalettes(c_long, const(char)*, long*) @nogc nothrow;
    int H5IMget_palette_info(c_long, const(char)*, int, ulong*) @nogc nothrow;
    int H5IMget_palette(c_long, const(char)*, int, ubyte*) @nogc nothrow;
    int H5IMis_image(c_long, const(char)*) @nogc nothrow;
    int H5IMis_palette(c_long, const(char)*) @nogc nothrow;
    enum H5I_type_t
    {
        H5I_UNINIT = -2,
        H5I_BADID = -1,
        H5I_FILE = 1,
        H5I_GROUP = 2,
        H5I_DATATYPE = 3,
        H5I_DATASPACE = 4,
        H5I_DATASET = 5,
        H5I_ATTR = 6,
        H5I_REFERENCE = 7,
        H5I_VFL = 8,
        H5I_GENPROP_CLS = 9,
        H5I_GENPROP_LST = 10,
        H5I_ERROR_CLASS = 11,
        H5I_ERROR_MSG = 12,
        H5I_ERROR_STACK = 13,
        H5I_NTYPES = 14,
    }
    enum H5I_UNINIT = H5I_type_t.H5I_UNINIT;
    enum H5I_BADID = H5I_type_t.H5I_BADID;
    enum H5I_FILE = H5I_type_t.H5I_FILE;
    enum H5I_GROUP = H5I_type_t.H5I_GROUP;
    enum H5I_DATATYPE = H5I_type_t.H5I_DATATYPE;
    enum H5I_DATASPACE = H5I_type_t.H5I_DATASPACE;
    enum H5I_DATASET = H5I_type_t.H5I_DATASET;
    enum H5I_ATTR = H5I_type_t.H5I_ATTR;
    enum H5I_REFERENCE = H5I_type_t.H5I_REFERENCE;
    enum H5I_VFL = H5I_type_t.H5I_VFL;
    enum H5I_GENPROP_CLS = H5I_type_t.H5I_GENPROP_CLS;
    enum H5I_GENPROP_LST = H5I_type_t.H5I_GENPROP_LST;
    enum H5I_ERROR_CLASS = H5I_type_t.H5I_ERROR_CLASS;
    enum H5I_ERROR_MSG = H5I_type_t.H5I_ERROR_MSG;
    enum H5I_ERROR_STACK = H5I_type_t.H5I_ERROR_STACK;
    enum H5I_NTYPES = H5I_type_t.H5I_NTYPES;
    alias hid_t = c_long;
    alias __clockid_t = int;
    alias H5I_free_t = int function(void*);
    alias H5I_search_func_t = int function(void*, c_long, void*);
    c_long H5Iregister(H5I_type_t, const(void)*) @nogc nothrow;
    void* H5Iobject_verify(c_long, H5I_type_t) @nogc nothrow;
    void* H5Iremove_verify(c_long, H5I_type_t) @nogc nothrow;
    H5I_type_t H5Iget_type(c_long) @nogc nothrow;
    c_long H5Iget_file_id(c_long) @nogc nothrow;
    c_long H5Iget_name(c_long, char*, c_ulong) @nogc nothrow;
    int H5Iinc_ref(c_long) @nogc nothrow;
    int H5Idec_ref(c_long) @nogc nothrow;
    int H5Iget_ref(c_long) @nogc nothrow;
    H5I_type_t H5Iregister_type(c_ulong, uint, int function(void*)) @nogc nothrow;
    int H5Iclear_type(H5I_type_t, bool) @nogc nothrow;
    int H5Idestroy_type(H5I_type_t) @nogc nothrow;
    int H5Iinc_type_ref(H5I_type_t) @nogc nothrow;
    int H5Idec_type_ref(H5I_type_t) @nogc nothrow;
    int H5Iget_type_ref(H5I_type_t) @nogc nothrow;
    void* H5Isearch(H5I_type_t, int function(void*, c_long, void*), void*) @nogc nothrow;
    int H5Inmembers(H5I_type_t, ulong*) @nogc nothrow;
    int H5Itype_exists(H5I_type_t) @nogc nothrow;
    int H5Iis_valid(c_long) @nogc nothrow;
    int H5LDget_dset_dims(c_long, ulong*) @nogc nothrow;
    c_ulong H5LDget_dset_type_size(c_long, const(char)*) @nogc nothrow;
    int H5LDget_dset_elmts(c_long, const(ulong)*, const(ulong)*, const(char)*, void*) @nogc nothrow;
    alias __key_t = int;
    alias __daddr_t = int;
    enum H5LT_lang_t
    {
        H5LT_LANG_ERR = -1,
        H5LT_DDL = 0,
        H5LT_C = 1,
        H5LT_FORTRAN = 2,
        H5LT_NO_LANG = 3,
    }
    enum H5LT_LANG_ERR = H5LT_lang_t.H5LT_LANG_ERR;
    enum H5LT_DDL = H5LT_lang_t.H5LT_DDL;
    enum H5LT_C = H5LT_lang_t.H5LT_C;
    enum H5LT_FORTRAN = H5LT_lang_t.H5LT_FORTRAN;
    enum H5LT_NO_LANG = H5LT_lang_t.H5LT_NO_LANG;
    int H5LTmake_dataset(c_long, const(char)*, int, const(ulong)*, c_long, const(void)*) @nogc nothrow;
    int H5LTmake_dataset_char(c_long, const(char)*, int, const(ulong)*, const(char)*) @nogc nothrow;
    int H5LTmake_dataset_short(c_long, const(char)*, int, const(ulong)*, const(short)*) @nogc nothrow;
    int H5LTmake_dataset_int(c_long, const(char)*, int, const(ulong)*, const(int)*) @nogc nothrow;
    int H5LTmake_dataset_long(c_long, const(char)*, int, const(ulong)*, const(c_long)*) @nogc nothrow;
    int H5LTmake_dataset_float(c_long, const(char)*, int, const(ulong)*, const(float)*) @nogc nothrow;
    int H5LTmake_dataset_double(c_long, const(char)*, int, const(ulong)*, const(double)*) @nogc nothrow;
    int H5LTmake_dataset_string(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5LTread_dataset(c_long, const(char)*, c_long, void*) @nogc nothrow;
    int H5LTread_dataset_char(c_long, const(char)*, char*) @nogc nothrow;
    int H5LTread_dataset_short(c_long, const(char)*, short*) @nogc nothrow;
    int H5LTread_dataset_int(c_long, const(char)*, int*) @nogc nothrow;
    int H5LTread_dataset_long(c_long, const(char)*, c_long*) @nogc nothrow;
    int H5LTread_dataset_float(c_long, const(char)*, float*) @nogc nothrow;
    int H5LTread_dataset_double(c_long, const(char)*, double*) @nogc nothrow;
    int H5LTread_dataset_string(c_long, const(char)*, char*) @nogc nothrow;
    int H5LTget_dataset_ndims(c_long, const(char)*, int*) @nogc nothrow;
    int H5LTget_dataset_info(c_long, const(char)*, ulong*, H5T_class_t*, c_ulong*) @nogc nothrow;
    int H5LTfind_dataset(c_long, const(char)*) @nogc nothrow;
    int H5LTset_attribute_string(c_long, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int H5LTset_attribute_char(c_long, const(char)*, const(char)*, const(char)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_uchar(c_long, const(char)*, const(char)*, const(ubyte)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_short(c_long, const(char)*, const(char)*, const(short)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_ushort(c_long, const(char)*, const(char)*, const(ushort)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_int(c_long, const(char)*, const(char)*, const(int)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_uint(c_long, const(char)*, const(char)*, const(uint)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_long(c_long, const(char)*, const(char)*, const(c_long)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_long_long(c_long, const(char)*, const(char)*, const(long)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_ulong(c_long, const(char)*, const(char)*, const(c_ulong)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_float(c_long, const(char)*, const(char)*, const(float)*, c_ulong) @nogc nothrow;
    int H5LTset_attribute_double(c_long, const(char)*, const(char)*, const(double)*, c_ulong) @nogc nothrow;
    int H5LTget_attribute(c_long, const(char)*, const(char)*, c_long, void*) @nogc nothrow;
    int H5LTget_attribute_string(c_long, const(char)*, const(char)*, char*) @nogc nothrow;
    int H5LTget_attribute_char(c_long, const(char)*, const(char)*, char*) @nogc nothrow;
    int H5LTget_attribute_uchar(c_long, const(char)*, const(char)*, ubyte*) @nogc nothrow;
    int H5LTget_attribute_short(c_long, const(char)*, const(char)*, short*) @nogc nothrow;
    int H5LTget_attribute_ushort(c_long, const(char)*, const(char)*, ushort*) @nogc nothrow;
    int H5LTget_attribute_int(c_long, const(char)*, const(char)*, int*) @nogc nothrow;
    int H5LTget_attribute_uint(c_long, const(char)*, const(char)*, uint*) @nogc nothrow;
    int H5LTget_attribute_long(c_long, const(char)*, const(char)*, c_long*) @nogc nothrow;
    int H5LTget_attribute_long_long(c_long, const(char)*, const(char)*, long*) @nogc nothrow;
    int H5LTget_attribute_ulong(c_long, const(char)*, const(char)*, c_ulong*) @nogc nothrow;
    int H5LTget_attribute_float(c_long, const(char)*, const(char)*, float*) @nogc nothrow;
    int H5LTget_attribute_double(c_long, const(char)*, const(char)*, double*) @nogc nothrow;
    int H5LTget_attribute_ndims(c_long, const(char)*, const(char)*, int*) @nogc nothrow;
    int H5LTget_attribute_info(c_long, const(char)*, const(char)*, ulong*, H5T_class_t*, c_ulong*) @nogc nothrow;
    c_long H5LTtext_to_dtype(const(char)*, H5LT_lang_t) @nogc nothrow;
    int H5LTdtype_to_text(c_long, char*, H5LT_lang_t, c_ulong*) @nogc nothrow;
    int H5LTfind_attribute(c_long, const(char)*) @nogc nothrow;
    int H5LTpath_valid(c_long, const(char)*, bool) @nogc nothrow;
    c_long H5LTopen_file_image(void*, c_ulong, uint) @nogc nothrow;
    alias __suseconds_t = c_long;
    alias H5L_type_t = _Anonymous_6;
    enum _Anonymous_6
    {
        H5L_TYPE_ERROR = -1,
        H5L_TYPE_HARD = 0,
        H5L_TYPE_SOFT = 1,
        H5L_TYPE_EXTERNAL = 64,
        H5L_TYPE_MAX = 255,
    }
    enum H5L_TYPE_ERROR = _Anonymous_6.H5L_TYPE_ERROR;
    enum H5L_TYPE_HARD = _Anonymous_6.H5L_TYPE_HARD;
    enum H5L_TYPE_SOFT = _Anonymous_6.H5L_TYPE_SOFT;
    enum H5L_TYPE_EXTERNAL = _Anonymous_6.H5L_TYPE_EXTERNAL;
    enum H5L_TYPE_MAX = _Anonymous_6.H5L_TYPE_MAX;
    alias __useconds_t = uint;
    struct H5L_info_t
    {
        @DppOffsetSize(0,4) H5L_type_t type;
        @DppOffsetSize(4,1) bool corder_valid;
        @DppOffsetSize(8,8) c_long corder;
        @DppOffsetSize(16,4) H5T_cset_t cset;
        static union _Anonymous_7
        {
            @DppOffsetSize(0,8) c_ulong address;
            @DppOffsetSize(0,8) c_ulong val_size;
        }
        @DppOffsetSize(24,8) _Anonymous_7 u;
    }
    alias H5L_create_func_t = int function(const(char)*, c_long, const(void)*, c_ulong, c_long);
    alias H5L_move_func_t = int function(const(char)*, c_long, const(void)*, c_ulong);
    alias H5L_copy_func_t = int function(const(char)*, c_long, const(void)*, c_ulong);
    alias H5L_traverse_0_func_t = c_long function(const(char)*, c_long, const(void)*, c_ulong, c_long);
    alias H5L_traverse_func_t = c_long function(const(char)*, c_long, const(void)*, c_ulong, c_long, c_long);
    alias H5L_delete_func_t = int function(const(char)*, c_long, const(void)*, c_ulong);
    alias H5L_query_func_t = c_long function(const(char)*, const(void)*, c_ulong, void*, c_ulong);
    struct H5L_class_0_t
    {
        @DppOffsetSize(0,4) int version_;
        @DppOffsetSize(4,4) H5L_type_t id;
        @DppOffsetSize(8,8) const(char)* comment;
        @DppOffsetSize(16,8) int function(const(char)*, c_long, const(void)*, c_ulong, c_long) create_func;
        @DppOffsetSize(24,8) int function(const(char)*, c_long, const(void)*, c_ulong) move_func;
        @DppOffsetSize(32,8) int function(const(char)*, c_long, const(void)*, c_ulong) copy_func;
        @DppOffsetSize(40,8) c_long function(const(char)*, c_long, const(void)*, c_ulong, c_long) trav_func;
        @DppOffsetSize(48,8) int function(const(char)*, c_long, const(void)*, c_ulong) del_func;
        @DppOffsetSize(56,8) c_long function(const(char)*, const(void)*, c_ulong, void*, c_ulong) query_func;
    }
    struct H5L_class_t
    {
        @DppOffsetSize(0,4) int version_;
        @DppOffsetSize(4,4) H5L_type_t id;
        @DppOffsetSize(8,8) const(char)* comment;
        @DppOffsetSize(16,8) int function(const(char)*, c_long, const(void)*, c_ulong, c_long) create_func;
        @DppOffsetSize(24,8) int function(const(char)*, c_long, const(void)*, c_ulong) move_func;
        @DppOffsetSize(32,8) int function(const(char)*, c_long, const(void)*, c_ulong) copy_func;
        @DppOffsetSize(40,8) c_long function(const(char)*, c_long, const(void)*, c_ulong, c_long, c_long) trav_func;
        @DppOffsetSize(48,8) int function(const(char)*, c_long, const(void)*, c_ulong) del_func;
        @DppOffsetSize(56,8) c_long function(const(char)*, const(void)*, c_ulong, void*, c_ulong) query_func;
    }
    alias H5L_iterate_t = int function(c_long, const(char)*, const(H5L_info_t)*, void*);
    alias H5L_elink_traverse_t = int function(const(char)*, const(char)*, const(char)*, const(char)*, uint*, c_long, void*);
    int H5Lmove(c_long, const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Lcopy(c_long, const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Lcreate_hard(c_long, const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Lcreate_soft(const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Ldelete(c_long, const(char)*, c_long) @nogc nothrow;
    int H5Ldelete_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, c_long) @nogc nothrow;
    int H5Lget_val(c_long, const(char)*, void*, c_ulong, c_long) @nogc nothrow;
    int H5Lget_val_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, void*, c_ulong, c_long) @nogc nothrow;
    int H5Lexists(c_long, const(char)*, c_long) @nogc nothrow;
    int H5Lget_info(c_long, const(char)*, H5L_info_t*, c_long) @nogc nothrow;
    int H5Lget_info_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5L_info_t*, c_long) @nogc nothrow;
    c_long H5Lget_name_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, char*, c_ulong, c_long) @nogc nothrow;
    int H5Literate(c_long, H5_index_t, H5_iter_order_t, ulong*, int function(c_long, const(char)*, const(H5L_info_t)*, void*), void*) @nogc nothrow;
    int H5Literate_by_name(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong*, int function(c_long, const(char)*, const(H5L_info_t)*, void*), void*, c_long) @nogc nothrow;
    int H5Lvisit(c_long, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5L_info_t)*, void*), void*) @nogc nothrow;
    int H5Lvisit_by_name(c_long, const(char)*, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5L_info_t)*, void*), void*, c_long) @nogc nothrow;
    int H5Lcreate_ud(c_long, const(char)*, H5L_type_t, const(void)*, c_ulong, c_long, c_long) @nogc nothrow;
    int H5Lregister(const(H5L_class_t)*) @nogc nothrow;
    int H5Lunregister(H5L_type_t) @nogc nothrow;
    int H5Lis_registered(H5L_type_t) @nogc nothrow;
    int H5Lunpack_elink_val(const(void)*, c_ulong, uint*, const(char)**, const(char)**) @nogc nothrow;
    int H5Lcreate_external(const(char)*, const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    alias H5MM_allocate_t = void* function(c_ulong, void*);
    alias H5MM_free_t = void function(void*, void*);
    alias __time_t = c_long;
    alias __id_t = uint;
    alias __rlim64_t = c_ulong;
    alias __rlim_t = c_ulong;
    alias __clock_t = c_long;
    struct __fsid_t
    {
        @DppOffsetSize(0,8) int[2] __val;
    }
    alias __pid_t = int;
    alias __off64_t = c_long;
    alias __off_t = c_long;
    alias __nlink_t = c_ulong;
    enum H5O_type_t
    {
        H5O_TYPE_UNKNOWN = -1,
        H5O_TYPE_GROUP = 0,
        H5O_TYPE_DATASET = 1,
        H5O_TYPE_NAMED_DATATYPE = 2,
        H5O_TYPE_NTYPES = 3,
    }
    enum H5O_TYPE_UNKNOWN = H5O_type_t.H5O_TYPE_UNKNOWN;
    enum H5O_TYPE_GROUP = H5O_type_t.H5O_TYPE_GROUP;
    enum H5O_TYPE_DATASET = H5O_type_t.H5O_TYPE_DATASET;
    enum H5O_TYPE_NAMED_DATATYPE = H5O_type_t.H5O_TYPE_NAMED_DATATYPE;
    enum H5O_TYPE_NTYPES = H5O_type_t.H5O_TYPE_NTYPES;
    struct H5O_hdr_info_t
    {
        @DppOffsetSize(0,4) uint version_;
        @DppOffsetSize(4,4) uint nmesgs;
        @DppOffsetSize(8,4) uint nchunks;
        @DppOffsetSize(12,4) uint flags;
        static struct _Anonymous_8
        {
            @DppOffsetSize(0,8) ulong total;
            @DppOffsetSize(8,8) ulong meta;
            @DppOffsetSize(16,8) ulong mesg;
            @DppOffsetSize(24,8) ulong free;
        }
        @DppOffsetSize(16,32) _Anonymous_8 space;
        static struct _Anonymous_9
        {
            @DppOffsetSize(0,8) c_ulong present;
            @DppOffsetSize(8,8) c_ulong shared_;
        }
        @DppOffsetSize(48,16) _Anonymous_9 mesg;
    }
    struct H5O_info_t
    {
        @DppOffsetSize(0,8) c_ulong fileno;
        @DppOffsetSize(8,8) c_ulong addr;
        @DppOffsetSize(16,4) H5O_type_t type;
        @DppOffsetSize(20,4) uint rc;
        @DppOffsetSize(24,8) c_long atime;
        @DppOffsetSize(32,8) c_long mtime;
        @DppOffsetSize(40,8) c_long ctime;
        @DppOffsetSize(48,8) c_long btime;
        @DppOffsetSize(56,8) ulong num_attrs;
        @DppOffsetSize(64,64) H5O_hdr_info_t hdr;
        static struct _Anonymous_10
        {
            @DppOffsetSize(0,16) H5_ih_info_t obj;
            @DppOffsetSize(16,16) H5_ih_info_t attr;
        }
        @DppOffsetSize(128,32) _Anonymous_10 meta_size;
    }
    alias H5O_msg_crt_idx_t = uint;
    alias H5O_iterate_t = int function(c_long, const(char)*, const(H5O_info_t)*, void*);
    enum H5O_mcdt_search_ret_t
    {
        H5O_MCDT_SEARCH_ERROR = -1,
        H5O_MCDT_SEARCH_CONT = 0,
        H5O_MCDT_SEARCH_STOP = 1,
    }
    enum H5O_MCDT_SEARCH_ERROR = H5O_mcdt_search_ret_t.H5O_MCDT_SEARCH_ERROR;
    enum H5O_MCDT_SEARCH_CONT = H5O_mcdt_search_ret_t.H5O_MCDT_SEARCH_CONT;
    enum H5O_MCDT_SEARCH_STOP = H5O_mcdt_search_ret_t.H5O_MCDT_SEARCH_STOP;
    alias H5O_mcdt_search_cb_t = H5O_mcdt_search_ret_t function(void*);
    c_long H5Oopen(c_long, const(char)*, c_long) @nogc nothrow;
    c_long H5Oopen_by_addr(c_long, c_ulong) @nogc nothrow;
    c_long H5Oopen_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, c_long) @nogc nothrow;
    int H5Oexists_by_name(c_long, const(char)*, c_long) @nogc nothrow;
    int H5Oget_info2(c_long, H5O_info_t*, uint) @nogc nothrow;
    int H5Oget_info_by_name2(c_long, const(char)*, H5O_info_t*, uint, c_long) @nogc nothrow;
    int H5Oget_info_by_idx2(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5O_info_t*, uint, c_long) @nogc nothrow;
    int H5Olink(c_long, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Oincr_refcount(c_long) @nogc nothrow;
    int H5Odecr_refcount(c_long) @nogc nothrow;
    int H5Ocopy(c_long, const(char)*, c_long, const(char)*, c_long, c_long) @nogc nothrow;
    int H5Oset_comment(c_long, const(char)*) @nogc nothrow;
    int H5Oset_comment_by_name(c_long, const(char)*, const(char)*, c_long) @nogc nothrow;
    c_long H5Oget_comment(c_long, char*, c_ulong) @nogc nothrow;
    c_long H5Oget_comment_by_name(c_long, const(char)*, char*, c_ulong, c_long) @nogc nothrow;
    int H5Ovisit2(c_long, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*, uint) @nogc nothrow;
    int H5Ovisit_by_name2(c_long, const(char)*, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*, uint, c_long) @nogc nothrow;
    int H5Oclose(c_long) @nogc nothrow;
    int H5Oflush(c_long) @nogc nothrow;
    int H5Orefresh(c_long) @nogc nothrow;
    int H5Odisable_mdc_flushes(c_long) @nogc nothrow;
    int H5Oenable_mdc_flushes(c_long) @nogc nothrow;
    int H5Oare_mdc_flushes_disabled(c_long, bool*) @nogc nothrow;
    int H5Oget_info(c_long, H5O_info_t*) @nogc nothrow;
    int H5Oget_info_by_name(c_long, const(char)*, H5O_info_t*, c_long) @nogc nothrow;
    int H5Oget_info_by_idx(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5O_info_t*, c_long) @nogc nothrow;
    int H5Ovisit(c_long, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*) @nogc nothrow;
    int H5Ovisit_by_name(c_long, const(char)*, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*, c_long) @nogc nothrow;
    int H5Oget_info1(c_long, H5O_info_t*) @nogc nothrow;
    int H5Oget_info_by_name1(c_long, const(char)*, H5O_info_t*, c_long) @nogc nothrow;
    int H5Oget_info_by_idx1(c_long, const(char)*, H5_index_t, H5_iter_order_t, ulong, H5O_info_t*, c_long) @nogc nothrow;
    int H5Ovisit1(c_long, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*) @nogc nothrow;
    int H5Ovisit_by_name1(c_long, const(char)*, H5_index_t, H5_iter_order_t, int function(c_long, const(char)*, const(H5O_info_t)*, void*), void*, c_long) @nogc nothrow;
    struct H5O_stat_t
    {
        @DppOffsetSize(0,8) ulong size;
        @DppOffsetSize(8,8) ulong free;
        @DppOffsetSize(16,4) uint nmesgs;
        @DppOffsetSize(20,4) uint nchunks;
    }
    enum H5PL_type_t
    {
        H5PL_TYPE_ERROR = -1,
        H5PL_TYPE_FILTER = 0,
        H5PL_TYPE_NONE = 1,
    }
    enum H5PL_TYPE_ERROR = H5PL_type_t.H5PL_TYPE_ERROR;
    enum H5PL_TYPE_FILTER = H5PL_type_t.H5PL_TYPE_FILTER;
    enum H5PL_TYPE_NONE = H5PL_type_t.H5PL_TYPE_NONE;
    alias __mode_t = uint;
    int H5PLset_loading_state(uint) @nogc nothrow;
    int H5PLget_loading_state(uint*) @nogc nothrow;
    int H5PLappend(const(char)*) @nogc nothrow;
    int H5PLprepend(const(char)*) @nogc nothrow;
    int H5PLreplace(const(char)*, uint) @nogc nothrow;
    int H5PLinsert(const(char)*, uint) @nogc nothrow;
    int H5PLremove(uint) @nogc nothrow;
    c_long H5PLget(uint, char*, c_ulong) @nogc nothrow;
    int H5PLsize(uint*) @nogc nothrow;
    alias __ino64_t = c_ulong;
    c_long H5PTcreate(c_long, const(char)*, c_long, ulong, c_long) @nogc nothrow;
    c_long H5PTopen(c_long, const(char)*) @nogc nothrow;
    int H5PTclose(c_long) @nogc nothrow;
    c_long H5PTcreate_fl(c_long, const(char)*, c_long, ulong, int) @nogc nothrow;
    int H5PTappend(c_long, c_ulong, const(void)*) @nogc nothrow;
    int H5PTget_next(c_long, c_ulong, void*) @nogc nothrow;
    int H5PTread_packets(c_long, ulong, c_ulong, void*) @nogc nothrow;
    int H5PTget_num_packets(c_long, ulong*) @nogc nothrow;
    int H5PTis_valid(c_long) @nogc nothrow;
    int H5PTis_varlen(c_long) @nogc nothrow;
    c_long H5PTget_dataset(c_long) @nogc nothrow;
    c_long H5PTget_type(c_long) @nogc nothrow;
    int H5PTcreate_index(c_long) @nogc nothrow;
    int H5PTset_index(c_long, ulong) @nogc nothrow;
    int H5PTget_index(c_long, ulong*) @nogc nothrow;
    int H5PTfree_vlen_buff(c_long, c_ulong, void*) @nogc nothrow;
    alias __ino_t = c_ulong;
    alias __gid_t = uint;
    alias __uid_t = uint;
    alias __dev_t = c_ulong;
    alias __uintmax_t = c_ulong;
    alias __intmax_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __quad_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __int_least64_t = c_long;
    alias __uint_least32_t = uint;
    alias __int_least32_t = int;
    alias __uint_least16_t = ushort;
    alias __int_least16_t = short;
    alias __uint_least8_t = ubyte;
    alias __int_least8_t = byte;
    alias __uint64_t = c_ulong;
    alias __int64_t = c_long;
    alias __uint32_t = uint;
    alias __int32_t = int;
    alias __uint16_t = ushort;
    alias __int16_t = short;
    alias __uint8_t = ubyte;
    alias H5P_cls_create_func_t = int function(c_long, void*);
    alias H5P_cls_copy_func_t = int function(c_long, c_long, void*);
    alias H5P_cls_close_func_t = int function(c_long, void*);
    alias H5P_prp_cb1_t = int function(const(char)*, c_ulong, void*);
    alias H5P_prp_cb2_t = int function(c_long, const(char)*, c_ulong, void*);
    alias H5P_prp_create_func_t = int function();
    alias H5P_prp_set_func_t = int function();
    alias H5P_prp_get_func_t = int function();
    alias H5P_prp_delete_func_t = int function();
    alias H5P_prp_copy_func_t = int function();
    alias H5P_prp_compare_func_t = int function(const(void)*, const(void)*, c_ulong);
    alias H5P_prp_close_func_t = int function();
    alias H5P_iterate_t = int function(c_long, const(char)*, void*);
    enum H5D_mpio_actual_chunk_opt_mode_t
    {
        H5D_MPIO_NO_CHUNK_OPTIMIZATION = 0,
        H5D_MPIO_LINK_CHUNK = 1,
        H5D_MPIO_MULTI_CHUNK = 2,
    }
    enum H5D_MPIO_NO_CHUNK_OPTIMIZATION = H5D_mpio_actual_chunk_opt_mode_t.H5D_MPIO_NO_CHUNK_OPTIMIZATION;
    enum H5D_MPIO_LINK_CHUNK = H5D_mpio_actual_chunk_opt_mode_t.H5D_MPIO_LINK_CHUNK;
    enum H5D_MPIO_MULTI_CHUNK = H5D_mpio_actual_chunk_opt_mode_t.H5D_MPIO_MULTI_CHUNK;
    enum H5D_mpio_actual_io_mode_t
    {
        H5D_MPIO_NO_COLLECTIVE = 0,
        H5D_MPIO_CHUNK_INDEPENDENT = 1,
        H5D_MPIO_CHUNK_COLLECTIVE = 2,
        H5D_MPIO_CHUNK_MIXED = 3,
        H5D_MPIO_CONTIGUOUS_COLLECTIVE = 4,
    }
    enum H5D_MPIO_NO_COLLECTIVE = H5D_mpio_actual_io_mode_t.H5D_MPIO_NO_COLLECTIVE;
    enum H5D_MPIO_CHUNK_INDEPENDENT = H5D_mpio_actual_io_mode_t.H5D_MPIO_CHUNK_INDEPENDENT;
    enum H5D_MPIO_CHUNK_COLLECTIVE = H5D_mpio_actual_io_mode_t.H5D_MPIO_CHUNK_COLLECTIVE;
    enum H5D_MPIO_CHUNK_MIXED = H5D_mpio_actual_io_mode_t.H5D_MPIO_CHUNK_MIXED;
    enum H5D_MPIO_CONTIGUOUS_COLLECTIVE = H5D_mpio_actual_io_mode_t.H5D_MPIO_CONTIGUOUS_COLLECTIVE;
    enum H5D_mpio_no_collective_cause_t
    {
        H5D_MPIO_COLLECTIVE = 0,
        H5D_MPIO_SET_INDEPENDENT = 1,
        H5D_MPIO_DATATYPE_CONVERSION = 2,
        H5D_MPIO_DATA_TRANSFORMS = 4,
        H5D_MPIO_MPI_OPT_TYPES_ENV_VAR_DISABLED = 8,
        H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES = 16,
        H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET = 32,
        H5D_MPIO_PARALLEL_FILTERED_WRITES_DISABLED = 64,
        H5D_MPIO_ERROR_WHILE_CHECKING_COLLECTIVE_POSSIBLE = 128,
        H5D_MPIO_NO_COLLECTIVE_MAX_CAUSE = 256,
    }
    enum H5D_MPIO_COLLECTIVE = H5D_mpio_no_collective_cause_t.H5D_MPIO_COLLECTIVE;
    enum H5D_MPIO_SET_INDEPENDENT = H5D_mpio_no_collective_cause_t.H5D_MPIO_SET_INDEPENDENT;
    enum H5D_MPIO_DATATYPE_CONVERSION = H5D_mpio_no_collective_cause_t.H5D_MPIO_DATATYPE_CONVERSION;
    enum H5D_MPIO_DATA_TRANSFORMS = H5D_mpio_no_collective_cause_t.H5D_MPIO_DATA_TRANSFORMS;
    enum H5D_MPIO_MPI_OPT_TYPES_ENV_VAR_DISABLED = H5D_mpio_no_collective_cause_t.H5D_MPIO_MPI_OPT_TYPES_ENV_VAR_DISABLED;
    enum H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES = H5D_mpio_no_collective_cause_t.H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES;
    enum H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET = H5D_mpio_no_collective_cause_t.H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET;
    enum H5D_MPIO_PARALLEL_FILTERED_WRITES_DISABLED = H5D_mpio_no_collective_cause_t.H5D_MPIO_PARALLEL_FILTERED_WRITES_DISABLED;
    enum H5D_MPIO_ERROR_WHILE_CHECKING_COLLECTIVE_POSSIBLE = H5D_mpio_no_collective_cause_t.H5D_MPIO_ERROR_WHILE_CHECKING_COLLECTIVE_POSSIBLE;
    enum H5D_MPIO_NO_COLLECTIVE_MAX_CAUSE = H5D_mpio_no_collective_cause_t.H5D_MPIO_NO_COLLECTIVE_MAX_CAUSE;
    extern __gshared c_long H5P_CLS_ROOT_ID_g;
    extern __gshared c_long H5P_CLS_OBJECT_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_FILE_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_FILE_ACCESS_ID_g;
    extern __gshared c_long H5P_CLS_DATASET_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_DATASET_ACCESS_ID_g;
    extern __gshared c_long H5P_CLS_DATASET_XFER_ID_g;
    extern __gshared c_long H5P_CLS_FILE_MOUNT_ID_g;
    extern __gshared c_long H5P_CLS_GROUP_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_GROUP_ACCESS_ID_g;
    extern __gshared c_long H5P_CLS_DATATYPE_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_DATATYPE_ACCESS_ID_g;
    extern __gshared c_long H5P_CLS_STRING_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_ATTRIBUTE_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_ATTRIBUTE_ACCESS_ID_g;
    extern __gshared c_long H5P_CLS_OBJECT_COPY_ID_g;
    extern __gshared c_long H5P_CLS_LINK_CREATE_ID_g;
    extern __gshared c_long H5P_CLS_LINK_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_FILE_CREATE_ID_g;
    extern __gshared c_long H5P_LST_FILE_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_DATASET_CREATE_ID_g;
    extern __gshared c_long H5P_LST_DATASET_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_DATASET_XFER_ID_g;
    extern __gshared c_long H5P_LST_FILE_MOUNT_ID_g;
    extern __gshared c_long H5P_LST_GROUP_CREATE_ID_g;
    extern __gshared c_long H5P_LST_GROUP_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_DATATYPE_CREATE_ID_g;
    extern __gshared c_long H5P_LST_DATATYPE_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_ATTRIBUTE_CREATE_ID_g;
    extern __gshared c_long H5P_LST_ATTRIBUTE_ACCESS_ID_g;
    extern __gshared c_long H5P_LST_OBJECT_COPY_ID_g;
    extern __gshared c_long H5P_LST_LINK_CREATE_ID_g;
    extern __gshared c_long H5P_LST_LINK_ACCESS_ID_g;
    c_long H5Pcreate_class(c_long, const(char)*, int function(c_long, void*), void*, int function(c_long, c_long, void*), void*, int function(c_long, void*), void*) @nogc nothrow;
    char* H5Pget_class_name(c_long) @nogc nothrow;
    c_long H5Pcreate(c_long) @nogc nothrow;
    int H5Pregister2(c_long, const(char)*, c_ulong, void*, int function(const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*), int function(const(void)*, const(void)*, c_ulong), int function(const(char)*, c_ulong, void*)) @nogc nothrow;
    int H5Pinsert2(c_long, const(char)*, c_ulong, void*, int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*), int function(const(void)*, const(void)*, c_ulong), int function(const(char)*, c_ulong, void*)) @nogc nothrow;
    int H5Pset(c_long, const(char)*, const(void)*) @nogc nothrow;
    int H5Pexist(c_long, const(char)*) @nogc nothrow;
    int H5Pencode(c_long, void*, c_ulong*) @nogc nothrow;
    c_long H5Pdecode(const(void)*) @nogc nothrow;
    int H5Pget_size(c_long, const(char)*, c_ulong*) @nogc nothrow;
    int H5Pget_nprops(c_long, c_ulong*) @nogc nothrow;
    c_long H5Pget_class(c_long) @nogc nothrow;
    c_long H5Pget_class_parent(c_long) @nogc nothrow;
    int H5Pget(c_long, const(char)*, void*) @nogc nothrow;
    int H5Pequal(c_long, c_long) @nogc nothrow;
    int H5Pisa_class(c_long, c_long) @nogc nothrow;
    int H5Piterate(c_long, int*, int function(c_long, const(char)*, void*), void*) @nogc nothrow;
    int H5Pcopy_prop(c_long, c_long, const(char)*) @nogc nothrow;
    int H5Premove(c_long, const(char)*) @nogc nothrow;
    int H5Punregister(c_long, const(char)*) @nogc nothrow;
    int H5Pclose_class(c_long) @nogc nothrow;
    int H5Pclose(c_long) @nogc nothrow;
    c_long H5Pcopy(c_long) @nogc nothrow;
    int H5Pset_attr_phase_change(c_long, uint, uint) @nogc nothrow;
    int H5Pget_attr_phase_change(c_long, uint*, uint*) @nogc nothrow;
    int H5Pset_attr_creation_order(c_long, uint) @nogc nothrow;
    int H5Pget_attr_creation_order(c_long, uint*) @nogc nothrow;
    int H5Pset_obj_track_times(c_long, bool) @nogc nothrow;
    int H5Pget_obj_track_times(c_long, bool*) @nogc nothrow;
    int H5Pmodify_filter(c_long, int, uint, c_ulong, const(uint)*) @nogc nothrow;
    int H5Pset_filter(c_long, int, uint, c_ulong, const(uint)*) @nogc nothrow;
    int H5Pget_nfilters(c_long) @nogc nothrow;
    int H5Pget_filter2(c_long, uint, uint*, c_ulong*, uint*, c_ulong, char*, uint*) @nogc nothrow;
    int H5Pget_filter_by_id2(c_long, int, uint*, c_ulong*, uint*, c_ulong, char*, uint*) @nogc nothrow;
    int H5Pall_filters_avail(c_long) @nogc nothrow;
    int H5Premove_filter(c_long, int) @nogc nothrow;
    int H5Pset_deflate(c_long, uint) @nogc nothrow;
    int H5Pset_fletcher32(c_long) @nogc nothrow;
    int H5Pset_userblock(c_long, ulong) @nogc nothrow;
    int H5Pget_userblock(c_long, ulong*) @nogc nothrow;
    int H5Pset_sizes(c_long, c_ulong, c_ulong) @nogc nothrow;
    int H5Pget_sizes(c_long, c_ulong*, c_ulong*) @nogc nothrow;
    int H5Pset_sym_k(c_long, uint, uint) @nogc nothrow;
    int H5Pget_sym_k(c_long, uint*, uint*) @nogc nothrow;
    int H5Pset_istore_k(c_long, uint) @nogc nothrow;
    int H5Pget_istore_k(c_long, uint*) @nogc nothrow;
    int H5Pset_shared_mesg_nindexes(c_long, uint) @nogc nothrow;
    int H5Pget_shared_mesg_nindexes(c_long, uint*) @nogc nothrow;
    int H5Pset_shared_mesg_index(c_long, uint, uint, uint) @nogc nothrow;
    int H5Pget_shared_mesg_index(c_long, uint, uint*, uint*) @nogc nothrow;
    int H5Pset_shared_mesg_phase_change(c_long, uint, uint) @nogc nothrow;
    int H5Pget_shared_mesg_phase_change(c_long, uint*, uint*) @nogc nothrow;
    int H5Pset_file_space_strategy(c_long, H5F_fspace_strategy_t, bool, ulong) @nogc nothrow;
    int H5Pget_file_space_strategy(c_long, H5F_fspace_strategy_t*, bool*, ulong*) @nogc nothrow;
    int H5Pset_file_space_page_size(c_long, ulong) @nogc nothrow;
    int H5Pget_file_space_page_size(c_long, ulong*) @nogc nothrow;
    int H5Pset_alignment(c_long, ulong, ulong) @nogc nothrow;
    int H5Pget_alignment(c_long, ulong*, ulong*) @nogc nothrow;
    int H5Pset_driver(c_long, c_long, const(void)*) @nogc nothrow;
    c_long H5Pget_driver(c_long) @nogc nothrow;
    const(void)* H5Pget_driver_info(c_long) @nogc nothrow;
    int H5Pset_family_offset(c_long, ulong) @nogc nothrow;
    int H5Pget_family_offset(c_long, ulong*) @nogc nothrow;
    int H5Pset_multi_type(c_long, H5F_mem_t) @nogc nothrow;
    int H5Pget_multi_type(c_long, H5F_mem_t*) @nogc nothrow;
    int H5Pset_cache(c_long, int, c_ulong, c_ulong, double) @nogc nothrow;
    int H5Pget_cache(c_long, int*, c_ulong*, c_ulong*, double*) @nogc nothrow;
    int H5Pset_mdc_config(c_long, H5AC_cache_config_t*) @nogc nothrow;
    int H5Pget_mdc_config(c_long, H5AC_cache_config_t*) @nogc nothrow;
    int H5Pset_gc_references(c_long, uint) @nogc nothrow;
    int H5Pget_gc_references(c_long, uint*) @nogc nothrow;
    int H5Pset_fclose_degree(c_long, H5F_close_degree_t) @nogc nothrow;
    int H5Pget_fclose_degree(c_long, H5F_close_degree_t*) @nogc nothrow;
    int H5Pset_meta_block_size(c_long, ulong) @nogc nothrow;
    int H5Pget_meta_block_size(c_long, ulong*) @nogc nothrow;
    int H5Pset_sieve_buf_size(c_long, c_ulong) @nogc nothrow;
    int H5Pget_sieve_buf_size(c_long, c_ulong*) @nogc nothrow;
    int H5Pset_small_data_block_size(c_long, ulong) @nogc nothrow;
    int H5Pget_small_data_block_size(c_long, ulong*) @nogc nothrow;
    int H5Pset_libver_bounds(c_long, H5F_libver_t, H5F_libver_t) @nogc nothrow;
    int H5Pget_libver_bounds(c_long, H5F_libver_t*, H5F_libver_t*) @nogc nothrow;
    int H5Pset_elink_file_cache_size(c_long, uint) @nogc nothrow;
    int H5Pget_elink_file_cache_size(c_long, uint*) @nogc nothrow;
    int H5Pset_file_image(c_long, void*, c_ulong) @nogc nothrow;
    int H5Pget_file_image(c_long, void**, c_ulong*) @nogc nothrow;
    int H5Pset_file_image_callbacks(c_long, H5FD_file_image_callbacks_t*) @nogc nothrow;
    int H5Pget_file_image_callbacks(c_long, H5FD_file_image_callbacks_t*) @nogc nothrow;
    int H5Pset_core_write_tracking(c_long, bool, c_ulong) @nogc nothrow;
    int H5Pget_core_write_tracking(c_long, bool*, c_ulong*) @nogc nothrow;
    int H5Pset_metadata_read_attempts(c_long, uint) @nogc nothrow;
    int H5Pget_metadata_read_attempts(c_long, uint*) @nogc nothrow;
    int H5Pset_object_flush_cb(c_long, int function(c_long, void*), void*) @nogc nothrow;
    int H5Pget_object_flush_cb(c_long, int function(c_long, void*)*, void**) @nogc nothrow;
    int H5Pset_mdc_log_options(c_long, bool, const(char)*, bool) @nogc nothrow;
    int H5Pget_mdc_log_options(c_long, bool*, char*, c_ulong*, bool*) @nogc nothrow;
    int H5Pset_evict_on_close(c_long, bool) @nogc nothrow;
    int H5Pget_evict_on_close(c_long, bool*) @nogc nothrow;
    int H5Pset_mdc_image_config(c_long, H5AC_cache_image_config_t*) @nogc nothrow;
    int H5Pget_mdc_image_config(c_long, H5AC_cache_image_config_t*) @nogc nothrow;
    int H5Pset_page_buffer_size(c_long, c_ulong, uint, uint) @nogc nothrow;
    int H5Pget_page_buffer_size(c_long, c_ulong*, uint*, uint*) @nogc nothrow;
    int H5Pset_layout(c_long, H5D_layout_t) @nogc nothrow;
    H5D_layout_t H5Pget_layout(c_long) @nogc nothrow;
    int H5Pset_chunk(c_long, int, const(ulong)*) @nogc nothrow;
    int H5Pget_chunk(c_long, int, ulong*) @nogc nothrow;
    int H5Pset_virtual(c_long, c_long, const(char)*, const(char)*, c_long) @nogc nothrow;
    int H5Pget_virtual_count(c_long, c_ulong*) @nogc nothrow;
    c_long H5Pget_virtual_vspace(c_long, c_ulong) @nogc nothrow;
    c_long H5Pget_virtual_srcspace(c_long, c_ulong) @nogc nothrow;
    c_long H5Pget_virtual_filename(c_long, c_ulong, char*, c_ulong) @nogc nothrow;
    c_long H5Pget_virtual_dsetname(c_long, c_ulong, char*, c_ulong) @nogc nothrow;
    int H5Pset_external(c_long, const(char)*, c_long, ulong) @nogc nothrow;
    int H5Pset_chunk_opts(c_long, uint) @nogc nothrow;
    int H5Pget_chunk_opts(c_long, uint*) @nogc nothrow;
    int H5Pget_external_count(c_long) @nogc nothrow;
    int H5Pget_external(c_long, uint, c_ulong, char*, c_long*, ulong*) @nogc nothrow;
    int H5Pset_szip(c_long, uint, uint) @nogc nothrow;
    int H5Pset_shuffle(c_long) @nogc nothrow;
    int H5Pset_nbit(c_long) @nogc nothrow;
    int H5Pset_scaleoffset(c_long, H5Z_SO_scale_type_t, int) @nogc nothrow;
    int H5Pset_fill_value(c_long, c_long, const(void)*) @nogc nothrow;
    int H5Pget_fill_value(c_long, c_long, void*) @nogc nothrow;
    int H5Pfill_value_defined(c_long, H5D_fill_value_t*) @nogc nothrow;
    int H5Pset_alloc_time(c_long, H5D_alloc_time_t) @nogc nothrow;
    int H5Pget_alloc_time(c_long, H5D_alloc_time_t*) @nogc nothrow;
    int H5Pset_fill_time(c_long, H5D_fill_time_t) @nogc nothrow;
    int H5Pget_fill_time(c_long, H5D_fill_time_t*) @nogc nothrow;
    int H5Pget_dset_no_attrs_hint(c_long, bool*) @nogc nothrow;
    int H5Pset_dset_no_attrs_hint(c_long, bool) @nogc nothrow;
    int H5Pset_chunk_cache(c_long, c_ulong, c_ulong, double) @nogc nothrow;
    int H5Pget_chunk_cache(c_long, c_ulong*, c_ulong*, double*) @nogc nothrow;
    int H5Pset_virtual_view(c_long, H5D_vds_view_t) @nogc nothrow;
    int H5Pget_virtual_view(c_long, H5D_vds_view_t*) @nogc nothrow;
    int H5Pset_virtual_printf_gap(c_long, ulong) @nogc nothrow;
    int H5Pget_virtual_printf_gap(c_long, ulong*) @nogc nothrow;
    int H5Pset_virtual_prefix(c_long, const(char)*) @nogc nothrow;
    c_long H5Pget_virtual_prefix(c_long, char*, c_ulong) @nogc nothrow;
    int H5Pset_append_flush(c_long, uint, const(ulong)*, int function(c_long, ulong*, void*), void*) @nogc nothrow;
    int H5Pget_append_flush(c_long, uint, ulong*, int function(c_long, ulong*, void*)*, void**) @nogc nothrow;
    int H5Pset_efile_prefix(c_long, const(char)*) @nogc nothrow;
    c_long H5Pget_efile_prefix(c_long, char*, c_ulong) @nogc nothrow;
    int H5Pset_data_transform(c_long, const(char)*) @nogc nothrow;
    c_long H5Pget_data_transform(c_long, char*, c_ulong) @nogc nothrow;
    int H5Pset_buffer(c_long, c_ulong, void*, void*) @nogc nothrow;
    c_ulong H5Pget_buffer(c_long, void**, void**) @nogc nothrow;
    int H5Pset_preserve(c_long, bool) @nogc nothrow;
    int H5Pget_preserve(c_long) @nogc nothrow;
    int H5Pset_edc_check(c_long, H5Z_EDC_t) @nogc nothrow;
    H5Z_EDC_t H5Pget_edc_check(c_long) @nogc nothrow;
    int H5Pset_filter_callback(c_long, H5Z_cb_return_t function(int, void*, c_ulong, void*), void*) @nogc nothrow;
    int H5Pset_btree_ratios(c_long, double, double, double) @nogc nothrow;
    int H5Pget_btree_ratios(c_long, double*, double*, double*) @nogc nothrow;
    int H5Pset_vlen_mem_manager(c_long, void* function(c_ulong, void*), void*, void function(void*, void*), void*) @nogc nothrow;
    int H5Pget_vlen_mem_manager(c_long, void* function(c_ulong, void*)*, void**, void function(void*, void*)*, void**) @nogc nothrow;
    int H5Pset_hyper_vector_size(c_long, c_ulong) @nogc nothrow;
    int H5Pget_hyper_vector_size(c_long, c_ulong*) @nogc nothrow;
    int H5Pset_type_conv_cb(c_long, H5T_conv_ret_t function(H5T_conv_except_t, c_long, c_long, void*, void*, void*), void*) @nogc nothrow;
    int H5Pget_type_conv_cb(c_long, H5T_conv_ret_t function(H5T_conv_except_t, c_long, c_long, void*, void*, void*)*, void**) @nogc nothrow;
    int H5Pset_create_intermediate_group(c_long, uint) @nogc nothrow;
    int H5Pget_create_intermediate_group(c_long, uint*) @nogc nothrow;
    int H5Pset_local_heap_size_hint(c_long, c_ulong) @nogc nothrow;
    int H5Pget_local_heap_size_hint(c_long, c_ulong*) @nogc nothrow;
    int H5Pset_link_phase_change(c_long, uint, uint) @nogc nothrow;
    int H5Pget_link_phase_change(c_long, uint*, uint*) @nogc nothrow;
    int H5Pset_est_link_info(c_long, uint, uint) @nogc nothrow;
    int H5Pget_est_link_info(c_long, uint*, uint*) @nogc nothrow;
    int H5Pset_link_creation_order(c_long, uint) @nogc nothrow;
    int H5Pget_link_creation_order(c_long, uint*) @nogc nothrow;
    int H5Pset_char_encoding(c_long, H5T_cset_t) @nogc nothrow;
    int H5Pget_char_encoding(c_long, H5T_cset_t*) @nogc nothrow;
    int H5Pset_nlinks(c_long, c_ulong) @nogc nothrow;
    int H5Pget_nlinks(c_long, c_ulong*) @nogc nothrow;
    int H5Pset_elink_prefix(c_long, const(char)*) @nogc nothrow;
    c_long H5Pget_elink_prefix(c_long, char*, c_ulong) @nogc nothrow;
    c_long H5Pget_elink_fapl(c_long) @nogc nothrow;
    int H5Pset_elink_fapl(c_long, c_long) @nogc nothrow;
    int H5Pset_elink_acc_flags(c_long, uint) @nogc nothrow;
    int H5Pget_elink_acc_flags(c_long, uint*) @nogc nothrow;
    int H5Pset_elink_cb(c_long, int function(const(char)*, const(char)*, const(char)*, const(char)*, uint*, c_long, void*), void*) @nogc nothrow;
    int H5Pget_elink_cb(c_long, int function(const(char)*, const(char)*, const(char)*, const(char)*, uint*, c_long, void*)*, void**) @nogc nothrow;
    int H5Pset_copy_object(c_long, uint) @nogc nothrow;
    int H5Pget_copy_object(c_long, uint*) @nogc nothrow;
    int H5Padd_merge_committed_dtype_path(c_long, const(char)*) @nogc nothrow;
    int H5Pfree_merge_committed_dtype_paths(c_long) @nogc nothrow;
    int H5Pset_mcdt_search_cb(c_long, H5O_mcdt_search_ret_t function(void*), void*) @nogc nothrow;
    int H5Pget_mcdt_search_cb(c_long, H5O_mcdt_search_ret_t function(void*)*, void**) @nogc nothrow;
    alias __int8_t = byte;
    int H5Pregister1(c_long, const(char)*, c_ulong, void*, int function(const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*)) @nogc nothrow;
    int H5Pinsert1(c_long, const(char)*, c_ulong, void*, int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(c_long, const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*), int function(const(char)*, c_ulong, void*)) @nogc nothrow;
    int H5Pget_filter1(c_long, uint, uint*, c_ulong*, uint*, c_ulong, char*) @nogc nothrow;
    int H5Pget_filter_by_id1(c_long, int, uint*, c_ulong*, uint*, c_ulong, char*) @nogc nothrow;
    int H5Pget_version(c_long, uint*, uint*, uint*, uint*) @nogc nothrow;
    int H5Pset_file_space(c_long, H5F_file_space_type_t, ulong) @nogc nothrow;
    int H5Pget_file_space(c_long, H5F_file_space_type_t*, ulong*) @nogc nothrow;
    alias __u_long = c_ulong;
    alias __u_int = uint;
    alias __u_short = ushort;
    enum H5R_type_t
    {
        H5R_BADTYPE = -1,
        H5R_OBJECT = 0,
        H5R_DATASET_REGION = 1,
        H5R_MAXTYPE = 2,
    }
    enum H5R_BADTYPE = H5R_type_t.H5R_BADTYPE;
    enum H5R_OBJECT = H5R_type_t.H5R_OBJECT;
    enum H5R_DATASET_REGION = H5R_type_t.H5R_DATASET_REGION;
    enum H5R_MAXTYPE = H5R_type_t.H5R_MAXTYPE;
    alias hobj_ref_t = c_ulong;
    alias hdset_reg_ref_t = ubyte[12];
    int H5Rcreate(void*, c_long, const(char)*, H5R_type_t, c_long) @nogc nothrow;
    c_long H5Rdereference2(c_long, c_long, H5R_type_t, const(void)*) @nogc nothrow;
    c_long H5Rget_region(c_long, H5R_type_t, const(void)*) @nogc nothrow;
    int H5Rget_obj_type2(c_long, H5R_type_t, const(void)*, H5O_type_t*) @nogc nothrow;
    c_long H5Rget_name(c_long, H5R_type_t, const(void)*, char*, c_ulong) @nogc nothrow;
    H5G_obj_t H5Rget_obj_type1(c_long, H5R_type_t, const(void)*) @nogc nothrow;
    c_long H5Rdereference1(c_long, H5R_type_t, const(void)*) @nogc nothrow;
    alias __u_char = ubyte;
    enum H5S_class_t
    {
        H5S_NO_CLASS = -1,
        H5S_SCALAR = 0,
        H5S_SIMPLE = 1,
        H5S_NULL = 2,
    }
    enum H5S_NO_CLASS = H5S_class_t.H5S_NO_CLASS;
    enum H5S_SCALAR = H5S_class_t.H5S_SCALAR;
    enum H5S_SIMPLE = H5S_class_t.H5S_SIMPLE;
    enum H5S_NULL = H5S_class_t.H5S_NULL;
    enum H5S_seloper_t
    {
        H5S_SELECT_NOOP = -1,
        H5S_SELECT_SET = 0,
        H5S_SELECT_OR = 1,
        H5S_SELECT_AND = 2,
        H5S_SELECT_XOR = 3,
        H5S_SELECT_NOTB = 4,
        H5S_SELECT_NOTA = 5,
        H5S_SELECT_APPEND = 6,
        H5S_SELECT_PREPEND = 7,
        H5S_SELECT_INVALID = 8,
    }
    enum H5S_SELECT_NOOP = H5S_seloper_t.H5S_SELECT_NOOP;
    enum H5S_SELECT_SET = H5S_seloper_t.H5S_SELECT_SET;
    enum H5S_SELECT_OR = H5S_seloper_t.H5S_SELECT_OR;
    enum H5S_SELECT_AND = H5S_seloper_t.H5S_SELECT_AND;
    enum H5S_SELECT_XOR = H5S_seloper_t.H5S_SELECT_XOR;
    enum H5S_SELECT_NOTB = H5S_seloper_t.H5S_SELECT_NOTB;
    enum H5S_SELECT_NOTA = H5S_seloper_t.H5S_SELECT_NOTA;
    enum H5S_SELECT_APPEND = H5S_seloper_t.H5S_SELECT_APPEND;
    enum H5S_SELECT_PREPEND = H5S_seloper_t.H5S_SELECT_PREPEND;
    enum H5S_SELECT_INVALID = H5S_seloper_t.H5S_SELECT_INVALID;
    alias H5S_sel_type = _Anonymous_11;
    enum _Anonymous_11
    {
        H5S_SEL_ERROR = -1,
        H5S_SEL_NONE = 0,
        H5S_SEL_POINTS = 1,
        H5S_SEL_HYPERSLABS = 2,
        H5S_SEL_ALL = 3,
        H5S_SEL_N = 4,
    }
    enum H5S_SEL_ERROR = _Anonymous_11.H5S_SEL_ERROR;
    enum H5S_SEL_NONE = _Anonymous_11.H5S_SEL_NONE;
    enum H5S_SEL_POINTS = _Anonymous_11.H5S_SEL_POINTS;
    enum H5S_SEL_HYPERSLABS = _Anonymous_11.H5S_SEL_HYPERSLABS;
    enum H5S_SEL_ALL = _Anonymous_11.H5S_SEL_ALL;
    enum H5S_SEL_N = _Anonymous_11.H5S_SEL_N;
    c_long H5Screate(H5S_class_t) @nogc nothrow;
    c_long H5Screate_simple(int, const(ulong)*, const(ulong)*) @nogc nothrow;
    int H5Sset_extent_simple(c_long, int, const(ulong)*, const(ulong)*) @nogc nothrow;
    c_long H5Scopy(c_long) @nogc nothrow;
    int H5Sclose(c_long) @nogc nothrow;
    int H5Sencode(c_long, void*, c_ulong*) @nogc nothrow;
    c_long H5Sdecode(const(void)*) @nogc nothrow;
    long H5Sget_simple_extent_npoints(c_long) @nogc nothrow;
    int H5Sget_simple_extent_ndims(c_long) @nogc nothrow;
    int H5Sget_simple_extent_dims(c_long, ulong*, ulong*) @nogc nothrow;
    int H5Sis_simple(c_long) @nogc nothrow;
    long H5Sget_select_npoints(c_long) @nogc nothrow;
    int H5Sselect_hyperslab(c_long, H5S_seloper_t, const(ulong)*, const(ulong)*, const(ulong)*, const(ulong)*) @nogc nothrow;
    int H5Sselect_elements(c_long, H5S_seloper_t, c_ulong, const(ulong)*) @nogc nothrow;
    H5S_class_t H5Sget_simple_extent_type(c_long) @nogc nothrow;
    int H5Sset_extent_none(c_long) @nogc nothrow;
    int H5Sextent_copy(c_long, c_long) @nogc nothrow;
    int H5Sextent_equal(c_long, c_long) @nogc nothrow;
    int H5Sselect_all(c_long) @nogc nothrow;
    int H5Sselect_none(c_long) @nogc nothrow;
    int H5Soffset_simple(c_long, const(long)*) @nogc nothrow;
    int H5Sselect_valid(c_long) @nogc nothrow;
    int H5Sis_regular_hyperslab(c_long) @nogc nothrow;
    int H5Sget_regular_hyperslab(c_long, ulong*, ulong*, ulong*, ulong*) @nogc nothrow;
    long H5Sget_select_hyper_nblocks(c_long) @nogc nothrow;
    long H5Sget_select_elem_npoints(c_long) @nogc nothrow;
    int H5Sget_select_hyper_blocklist(c_long, ulong, ulong, ulong*) @nogc nothrow;
    int H5Sget_select_elem_pointlist(c_long, ulong, ulong, ulong*) @nogc nothrow;
    int H5Sget_select_bounds(c_long, ulong*, ulong*) @nogc nothrow;
    H5S_sel_type H5Sget_select_type(c_long) @nogc nothrow;
    struct __pthread_cond_s
    {
        static union _Anonymous_12
        {
            @DppOffsetSize(0,8) ulong __wseq;
            static struct _Anonymous_13
            {
                @DppOffsetSize(0,4) uint __low;
                @DppOffsetSize(4,4) uint __high;
            }
            @DppOffsetSize(0,8) _Anonymous_13 __wseq32;
        }
        _Anonymous_12 _anonymous_14;
        auto __wseq() @property @nogc pure nothrow { return _anonymous_14.__wseq; }
        void __wseq(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_14.__wseq = val; }
        auto __wseq32() @property @nogc pure nothrow { return _anonymous_14.__wseq32; }
        void __wseq32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_14.__wseq32 = val; }
        static union _Anonymous_15
        {
            @DppOffsetSize(0,8) ulong __g1_start;
            static struct _Anonymous_16
            {
                @DppOffsetSize(0,4) uint __low;
                @DppOffsetSize(4,4) uint __high;
            }
            @DppOffsetSize(0,8) _Anonymous_16 __g1_start32;
        }
        _Anonymous_15 _anonymous_17;
        auto __g1_start() @property @nogc pure nothrow { return _anonymous_17.__g1_start; }
        void __g1_start(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_17.__g1_start = val; }
        auto __g1_start32() @property @nogc pure nothrow { return _anonymous_17.__g1_start32; }
        void __g1_start32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_17.__g1_start32 = val; }
        @DppOffsetSize(16,8) uint[2] __g_refs;
        @DppOffsetSize(24,8) uint[2] __g_size;
        @DppOffsetSize(32,4) uint __g1_orig_size;
        @DppOffsetSize(36,4) uint __wrefs;
        @DppOffsetSize(40,8) uint[2] __g_signals;
    }
    int H5TBmake_table(const(char)*, c_long, const(char)*, ulong, ulong, c_ulong, const(char)**, const(c_ulong)*, const(c_long)*, ulong, void*, int, const(void)*) @nogc nothrow;
    int H5TBappend_records(c_long, const(char)*, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, const(void)*) @nogc nothrow;
    int H5TBwrite_records(c_long, const(char)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, const(void)*) @nogc nothrow;
    int H5TBwrite_fields_name(c_long, const(char)*, const(char)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, const(void)*) @nogc nothrow;
    int H5TBwrite_fields_index(c_long, const(char)*, ulong, const(int)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, const(void)*) @nogc nothrow;
    int H5TBread_table(c_long, const(char)*, c_ulong, const(c_ulong)*, const(c_ulong)*, void*) @nogc nothrow;
    int H5TBread_fields_name(c_long, const(char)*, const(char)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, void*) @nogc nothrow;
    int H5TBread_fields_index(c_long, const(char)*, ulong, const(int)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, void*) @nogc nothrow;
    int H5TBread_records(c_long, const(char)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, void*) @nogc nothrow;
    int H5TBget_table_info(c_long, const(char)*, ulong*, ulong*) @nogc nothrow;
    int H5TBget_field_info(c_long, const(char)*, char**, c_ulong*, c_ulong*, c_ulong*) @nogc nothrow;
    int H5TBdelete_record(c_long, const(char)*, ulong, ulong) @nogc nothrow;
    int H5TBinsert_record(c_long, const(char)*, ulong, ulong, c_ulong, const(c_ulong)*, const(c_ulong)*, void*) @nogc nothrow;
    int H5TBadd_records_from(c_long, const(char)*, ulong, ulong, const(char)*, ulong) @nogc nothrow;
    int H5TBcombine_tables(c_long, const(char)*, c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5TBinsert_field(c_long, const(char)*, const(char)*, c_long, ulong, const(void)*, const(void)*) @nogc nothrow;
    int H5TBdelete_field(c_long, const(char)*, const(char)*) @nogc nothrow;
    int H5TBAget_title(c_long, char*) @nogc nothrow;
    int H5TBAget_fill(c_long, const(char)*, c_long, ubyte*) @nogc nothrow;
    enum H5T_class_t
    {
        H5T_NO_CLASS = -1,
        H5T_INTEGER = 0,
        H5T_FLOAT = 1,
        H5T_TIME = 2,
        H5T_STRING = 3,
        H5T_BITFIELD = 4,
        H5T_OPAQUE = 5,
        H5T_COMPOUND = 6,
        H5T_REFERENCE = 7,
        H5T_ENUM = 8,
        H5T_VLEN = 9,
        H5T_ARRAY = 10,
        H5T_NCLASSES = 11,
    }
    enum H5T_NO_CLASS = H5T_class_t.H5T_NO_CLASS;
    enum H5T_INTEGER = H5T_class_t.H5T_INTEGER;
    enum H5T_FLOAT = H5T_class_t.H5T_FLOAT;
    enum H5T_TIME = H5T_class_t.H5T_TIME;
    enum H5T_STRING = H5T_class_t.H5T_STRING;
    enum H5T_BITFIELD = H5T_class_t.H5T_BITFIELD;
    enum H5T_OPAQUE = H5T_class_t.H5T_OPAQUE;
    enum H5T_COMPOUND = H5T_class_t.H5T_COMPOUND;
    enum H5T_REFERENCE = H5T_class_t.H5T_REFERENCE;
    enum H5T_ENUM = H5T_class_t.H5T_ENUM;
    enum H5T_VLEN = H5T_class_t.H5T_VLEN;
    enum H5T_ARRAY = H5T_class_t.H5T_ARRAY;
    enum H5T_NCLASSES = H5T_class_t.H5T_NCLASSES;
    enum H5T_order_t
    {
        H5T_ORDER_ERROR = -1,
        H5T_ORDER_LE = 0,
        H5T_ORDER_BE = 1,
        H5T_ORDER_VAX = 2,
        H5T_ORDER_MIXED = 3,
        H5T_ORDER_NONE = 4,
    }
    enum H5T_ORDER_ERROR = H5T_order_t.H5T_ORDER_ERROR;
    enum H5T_ORDER_LE = H5T_order_t.H5T_ORDER_LE;
    enum H5T_ORDER_BE = H5T_order_t.H5T_ORDER_BE;
    enum H5T_ORDER_VAX = H5T_order_t.H5T_ORDER_VAX;
    enum H5T_ORDER_MIXED = H5T_order_t.H5T_ORDER_MIXED;
    enum H5T_ORDER_NONE = H5T_order_t.H5T_ORDER_NONE;
    enum H5T_sign_t
    {
        H5T_SGN_ERROR = -1,
        H5T_SGN_NONE = 0,
        H5T_SGN_2 = 1,
        H5T_NSGN = 2,
    }
    enum H5T_SGN_ERROR = H5T_sign_t.H5T_SGN_ERROR;
    enum H5T_SGN_NONE = H5T_sign_t.H5T_SGN_NONE;
    enum H5T_SGN_2 = H5T_sign_t.H5T_SGN_2;
    enum H5T_NSGN = H5T_sign_t.H5T_NSGN;
    enum H5T_norm_t
    {
        H5T_NORM_ERROR = -1,
        H5T_NORM_IMPLIED = 0,
        H5T_NORM_MSBSET = 1,
        H5T_NORM_NONE = 2,
    }
    enum H5T_NORM_ERROR = H5T_norm_t.H5T_NORM_ERROR;
    enum H5T_NORM_IMPLIED = H5T_norm_t.H5T_NORM_IMPLIED;
    enum H5T_NORM_MSBSET = H5T_norm_t.H5T_NORM_MSBSET;
    enum H5T_NORM_NONE = H5T_norm_t.H5T_NORM_NONE;
    enum H5T_cset_t
    {
        H5T_CSET_ERROR = -1,
        H5T_CSET_ASCII = 0,
        H5T_CSET_UTF8 = 1,
        H5T_CSET_RESERVED_2 = 2,
        H5T_CSET_RESERVED_3 = 3,
        H5T_CSET_RESERVED_4 = 4,
        H5T_CSET_RESERVED_5 = 5,
        H5T_CSET_RESERVED_6 = 6,
        H5T_CSET_RESERVED_7 = 7,
        H5T_CSET_RESERVED_8 = 8,
        H5T_CSET_RESERVED_9 = 9,
        H5T_CSET_RESERVED_10 = 10,
        H5T_CSET_RESERVED_11 = 11,
        H5T_CSET_RESERVED_12 = 12,
        H5T_CSET_RESERVED_13 = 13,
        H5T_CSET_RESERVED_14 = 14,
        H5T_CSET_RESERVED_15 = 15,
    }
    enum H5T_CSET_ERROR = H5T_cset_t.H5T_CSET_ERROR;
    enum H5T_CSET_ASCII = H5T_cset_t.H5T_CSET_ASCII;
    enum H5T_CSET_UTF8 = H5T_cset_t.H5T_CSET_UTF8;
    enum H5T_CSET_RESERVED_2 = H5T_cset_t.H5T_CSET_RESERVED_2;
    enum H5T_CSET_RESERVED_3 = H5T_cset_t.H5T_CSET_RESERVED_3;
    enum H5T_CSET_RESERVED_4 = H5T_cset_t.H5T_CSET_RESERVED_4;
    enum H5T_CSET_RESERVED_5 = H5T_cset_t.H5T_CSET_RESERVED_5;
    enum H5T_CSET_RESERVED_6 = H5T_cset_t.H5T_CSET_RESERVED_6;
    enum H5T_CSET_RESERVED_7 = H5T_cset_t.H5T_CSET_RESERVED_7;
    enum H5T_CSET_RESERVED_8 = H5T_cset_t.H5T_CSET_RESERVED_8;
    enum H5T_CSET_RESERVED_9 = H5T_cset_t.H5T_CSET_RESERVED_9;
    enum H5T_CSET_RESERVED_10 = H5T_cset_t.H5T_CSET_RESERVED_10;
    enum H5T_CSET_RESERVED_11 = H5T_cset_t.H5T_CSET_RESERVED_11;
    enum H5T_CSET_RESERVED_12 = H5T_cset_t.H5T_CSET_RESERVED_12;
    enum H5T_CSET_RESERVED_13 = H5T_cset_t.H5T_CSET_RESERVED_13;
    enum H5T_CSET_RESERVED_14 = H5T_cset_t.H5T_CSET_RESERVED_14;
    enum H5T_CSET_RESERVED_15 = H5T_cset_t.H5T_CSET_RESERVED_15;
    enum H5T_str_t
    {
        H5T_STR_ERROR = -1,
        H5T_STR_NULLTERM = 0,
        H5T_STR_NULLPAD = 1,
        H5T_STR_SPACEPAD = 2,
        H5T_STR_RESERVED_3 = 3,
        H5T_STR_RESERVED_4 = 4,
        H5T_STR_RESERVED_5 = 5,
        H5T_STR_RESERVED_6 = 6,
        H5T_STR_RESERVED_7 = 7,
        H5T_STR_RESERVED_8 = 8,
        H5T_STR_RESERVED_9 = 9,
        H5T_STR_RESERVED_10 = 10,
        H5T_STR_RESERVED_11 = 11,
        H5T_STR_RESERVED_12 = 12,
        H5T_STR_RESERVED_13 = 13,
        H5T_STR_RESERVED_14 = 14,
        H5T_STR_RESERVED_15 = 15,
    }
    enum H5T_STR_ERROR = H5T_str_t.H5T_STR_ERROR;
    enum H5T_STR_NULLTERM = H5T_str_t.H5T_STR_NULLTERM;
    enum H5T_STR_NULLPAD = H5T_str_t.H5T_STR_NULLPAD;
    enum H5T_STR_SPACEPAD = H5T_str_t.H5T_STR_SPACEPAD;
    enum H5T_STR_RESERVED_3 = H5T_str_t.H5T_STR_RESERVED_3;
    enum H5T_STR_RESERVED_4 = H5T_str_t.H5T_STR_RESERVED_4;
    enum H5T_STR_RESERVED_5 = H5T_str_t.H5T_STR_RESERVED_5;
    enum H5T_STR_RESERVED_6 = H5T_str_t.H5T_STR_RESERVED_6;
    enum H5T_STR_RESERVED_7 = H5T_str_t.H5T_STR_RESERVED_7;
    enum H5T_STR_RESERVED_8 = H5T_str_t.H5T_STR_RESERVED_8;
    enum H5T_STR_RESERVED_9 = H5T_str_t.H5T_STR_RESERVED_9;
    enum H5T_STR_RESERVED_10 = H5T_str_t.H5T_STR_RESERVED_10;
    enum H5T_STR_RESERVED_11 = H5T_str_t.H5T_STR_RESERVED_11;
    enum H5T_STR_RESERVED_12 = H5T_str_t.H5T_STR_RESERVED_12;
    enum H5T_STR_RESERVED_13 = H5T_str_t.H5T_STR_RESERVED_13;
    enum H5T_STR_RESERVED_14 = H5T_str_t.H5T_STR_RESERVED_14;
    enum H5T_STR_RESERVED_15 = H5T_str_t.H5T_STR_RESERVED_15;
    enum H5T_pad_t
    {
        H5T_PAD_ERROR = -1,
        H5T_PAD_ZERO = 0,
        H5T_PAD_ONE = 1,
        H5T_PAD_BACKGROUND = 2,
        H5T_NPAD = 3,
    }
    enum H5T_PAD_ERROR = H5T_pad_t.H5T_PAD_ERROR;
    enum H5T_PAD_ZERO = H5T_pad_t.H5T_PAD_ZERO;
    enum H5T_PAD_ONE = H5T_pad_t.H5T_PAD_ONE;
    enum H5T_PAD_BACKGROUND = H5T_pad_t.H5T_PAD_BACKGROUND;
    enum H5T_NPAD = H5T_pad_t.H5T_NPAD;
    enum H5T_cmd_t
    {
        H5T_CONV_INIT = 0,
        H5T_CONV_CONV = 1,
        H5T_CONV_FREE = 2,
    }
    enum H5T_CONV_INIT = H5T_cmd_t.H5T_CONV_INIT;
    enum H5T_CONV_CONV = H5T_cmd_t.H5T_CONV_CONV;
    enum H5T_CONV_FREE = H5T_cmd_t.H5T_CONV_FREE;
    enum H5T_bkg_t
    {
        H5T_BKG_NO = 0,
        H5T_BKG_TEMP = 1,
        H5T_BKG_YES = 2,
    }
    enum H5T_BKG_NO = H5T_bkg_t.H5T_BKG_NO;
    enum H5T_BKG_TEMP = H5T_bkg_t.H5T_BKG_TEMP;
    enum H5T_BKG_YES = H5T_bkg_t.H5T_BKG_YES;
    struct H5T_cdata_t
    {
        @DppOffsetSize(0,4) H5T_cmd_t command;
        @DppOffsetSize(4,4) H5T_bkg_t need_bkg;
        @DppOffsetSize(8,1) bool recalc;
        @DppOffsetSize(16,8) void* priv;
    }
    enum H5T_pers_t
    {
        H5T_PERS_DONTCARE = -1,
        H5T_PERS_HARD = 0,
        H5T_PERS_SOFT = 1,
    }
    enum H5T_PERS_DONTCARE = H5T_pers_t.H5T_PERS_DONTCARE;
    enum H5T_PERS_HARD = H5T_pers_t.H5T_PERS_HARD;
    enum H5T_PERS_SOFT = H5T_pers_t.H5T_PERS_SOFT;
    enum H5T_direction_t
    {
        H5T_DIR_DEFAULT = 0,
        H5T_DIR_ASCEND = 1,
        H5T_DIR_DESCEND = 2,
    }
    enum H5T_DIR_DEFAULT = H5T_direction_t.H5T_DIR_DEFAULT;
    enum H5T_DIR_ASCEND = H5T_direction_t.H5T_DIR_ASCEND;
    enum H5T_DIR_DESCEND = H5T_direction_t.H5T_DIR_DESCEND;
    enum H5T_conv_except_t
    {
        H5T_CONV_EXCEPT_RANGE_HI = 0,
        H5T_CONV_EXCEPT_RANGE_LOW = 1,
        H5T_CONV_EXCEPT_PRECISION = 2,
        H5T_CONV_EXCEPT_TRUNCATE = 3,
        H5T_CONV_EXCEPT_PINF = 4,
        H5T_CONV_EXCEPT_NINF = 5,
        H5T_CONV_EXCEPT_NAN = 6,
    }
    enum H5T_CONV_EXCEPT_RANGE_HI = H5T_conv_except_t.H5T_CONV_EXCEPT_RANGE_HI;
    enum H5T_CONV_EXCEPT_RANGE_LOW = H5T_conv_except_t.H5T_CONV_EXCEPT_RANGE_LOW;
    enum H5T_CONV_EXCEPT_PRECISION = H5T_conv_except_t.H5T_CONV_EXCEPT_PRECISION;
    enum H5T_CONV_EXCEPT_TRUNCATE = H5T_conv_except_t.H5T_CONV_EXCEPT_TRUNCATE;
    enum H5T_CONV_EXCEPT_PINF = H5T_conv_except_t.H5T_CONV_EXCEPT_PINF;
    enum H5T_CONV_EXCEPT_NINF = H5T_conv_except_t.H5T_CONV_EXCEPT_NINF;
    enum H5T_CONV_EXCEPT_NAN = H5T_conv_except_t.H5T_CONV_EXCEPT_NAN;
    enum H5T_conv_ret_t
    {
        H5T_CONV_ABORT = -1,
        H5T_CONV_UNHANDLED = 0,
        H5T_CONV_HANDLED = 1,
    }
    enum H5T_CONV_ABORT = H5T_conv_ret_t.H5T_CONV_ABORT;
    enum H5T_CONV_UNHANDLED = H5T_conv_ret_t.H5T_CONV_UNHANDLED;
    enum H5T_CONV_HANDLED = H5T_conv_ret_t.H5T_CONV_HANDLED;
    struct hvl_t
    {
        @DppOffsetSize(0,8) c_ulong len;
        @DppOffsetSize(8,8) void* p;
    }
    alias H5T_conv_t = int function(c_long, c_long, H5T_cdata_t*, c_ulong, c_ulong, c_ulong, void*, void*, c_long);
    alias H5T_conv_except_func_t = H5T_conv_ret_t function(H5T_conv_except_t, c_long, c_long, void*, void*, void*);
    struct __pthread_mutex_s
    {
        @DppOffsetSize(0,4) int __lock;
        @DppOffsetSize(4,4) uint __count;
        @DppOffsetSize(8,4) int __owner;
        @DppOffsetSize(12,4) uint __nusers;
        @DppOffsetSize(16,4) int __kind;
        @DppOffsetSize(20,2) short __spins;
        @DppOffsetSize(22,2) short __elision;
        @DppOffsetSize(24,16) __pthread_internal_list __list;
    }
    struct __pthread_internal_list
    {
        @DppOffsetSize(0,8) __pthread_internal_list* __prev;
        @DppOffsetSize(8,8) __pthread_internal_list* __next;
    }
    extern __gshared c_long H5T_IEEE_F32BE_g;
    extern __gshared c_long H5T_IEEE_F32LE_g;
    extern __gshared c_long H5T_IEEE_F64BE_g;
    extern __gshared c_long H5T_IEEE_F64LE_g;
    alias __pthread_list_t = __pthread_internal_list;
    extern __gshared const(const(char)*)[0] sys_errlist;
    extern __gshared int sys_nerr;
    alias uint64_t = ulong;
    alias uint32_t = uint;
    alias uint16_t = ushort;
    alias uint8_t = ubyte;
    alias int64_t = c_long;
    alias int32_t = int;
    alias int16_t = short;
    alias int8_t = byte;
    extern __gshared c_long H5T_STD_I8BE_g;
    extern __gshared c_long H5T_STD_I8LE_g;
    extern __gshared c_long H5T_STD_I16BE_g;
    extern __gshared c_long H5T_STD_I16LE_g;
    extern __gshared c_long H5T_STD_I32BE_g;
    extern __gshared c_long H5T_STD_I32LE_g;
    extern __gshared c_long H5T_STD_I64BE_g;
    extern __gshared c_long H5T_STD_I64LE_g;
    extern __gshared c_long H5T_STD_U8BE_g;
    extern __gshared c_long H5T_STD_U8LE_g;
    extern __gshared c_long H5T_STD_U16BE_g;
    extern __gshared c_long H5T_STD_U16LE_g;
    extern __gshared c_long H5T_STD_U32BE_g;
    extern __gshared c_long H5T_STD_U32LE_g;
    extern __gshared c_long H5T_STD_U64BE_g;
    extern __gshared c_long H5T_STD_U64LE_g;
    extern __gshared c_long H5T_STD_B8BE_g;
    extern __gshared c_long H5T_STD_B8LE_g;
    extern __gshared c_long H5T_STD_B16BE_g;
    extern __gshared c_long H5T_STD_B16LE_g;
    extern __gshared c_long H5T_STD_B32BE_g;
    extern __gshared c_long H5T_STD_B32LE_g;
    extern __gshared c_long H5T_STD_B64BE_g;
    extern __gshared c_long H5T_STD_B64LE_g;
    extern __gshared c_long H5T_STD_REF_OBJ_g;
    extern __gshared c_long H5T_STD_REF_DSETREG_g;
    union pthread_barrierattr_t
    {
        @DppOffsetSize(0,4) char[4] __size;
        @DppOffsetSize(0,4) int __align;
    }
    extern __gshared c_long H5T_UNIX_D32BE_g;
    extern __gshared c_long H5T_UNIX_D32LE_g;
    extern __gshared c_long H5T_UNIX_D64BE_g;
    extern __gshared c_long H5T_UNIX_D64LE_g;
    union pthread_barrier_t
    {
        @DppOffsetSize(0,32) char[32] __size;
        @DppOffsetSize(0,8) c_long __align;
    }
    extern __gshared c_long H5T_C_S1_g;
    alias pthread_spinlock_t = int;
    extern __gshared c_long H5T_FORTRAN_S1_g;
    union pthread_rwlockattr_t
    {
        @DppOffsetSize(0,8) char[8] __size;
        @DppOffsetSize(0,8) c_long __align;
    }
    union pthread_rwlock_t
    {
        @DppOffsetSize(0,56) __pthread_rwlock_arch_t __data;
        @DppOffsetSize(0,56) char[56] __size;
        @DppOffsetSize(0,8) c_long __align;
    }
    union pthread_cond_t
    {
        @DppOffsetSize(0,48) __pthread_cond_s __data;
        @DppOffsetSize(0,48) char[48] __size;
        @DppOffsetSize(0,8) long __align;
    }
    union pthread_mutex_t
    {
        @DppOffsetSize(0,40) __pthread_mutex_s __data;
        @DppOffsetSize(0,40) char[40] __size;
        @DppOffsetSize(0,8) c_long __align;
    }
    union pthread_attr_t
    {
        @DppOffsetSize(0,56) char[56] __size;
        @DppOffsetSize(0,8) c_long __align;
    }
    alias pthread_once_t = int;
    alias pthread_key_t = uint;
    union pthread_condattr_t
    {
        @DppOffsetSize(0,4) char[4] __size;
        @DppOffsetSize(0,4) int __align;
    }
    union pthread_mutexattr_t
    {
        @DppOffsetSize(0,4) char[4] __size;
        @DppOffsetSize(0,4) int __align;
    }
    alias pthread_t = c_ulong;
    struct __pthread_rwlock_arch_t
    {
        @DppOffsetSize(0,4) uint __readers;
        @DppOffsetSize(4,4) uint __writers;
        @DppOffsetSize(8,4) uint __wrphase_futex;
        @DppOffsetSize(12,4) uint __writers_futex;
        @DppOffsetSize(16,4) uint __pad3;
        @DppOffsetSize(20,4) uint __pad4;
        @DppOffsetSize(24,4) int __cur_writer;
        @DppOffsetSize(28,4) int __shared;
        @DppOffsetSize(32,1) byte __rwelision;
        @DppOffsetSize(33,7) ubyte[7] __pad1;
        @DppOffsetSize(40,8) c_ulong __pad2;
        @DppOffsetSize(48,4) uint __flags;
    }
    extern __gshared c_long H5T_VAX_F32_g;
    extern __gshared c_long H5T_VAX_F64_g;
    extern __gshared c_long H5T_NATIVE_SCHAR_g;
    extern __gshared c_long H5T_NATIVE_UCHAR_g;
    extern __gshared c_long H5T_NATIVE_SHORT_g;
    extern __gshared c_long H5T_NATIVE_USHORT_g;
    extern __gshared c_long H5T_NATIVE_INT_g;
    extern __gshared c_long H5T_NATIVE_UINT_g;
    extern __gshared c_long H5T_NATIVE_LONG_g;
    extern __gshared c_long H5T_NATIVE_ULONG_g;
    extern __gshared c_long H5T_NATIVE_LLONG_g;
    extern __gshared c_long H5T_NATIVE_ULLONG_g;
    extern __gshared c_long H5T_NATIVE_FLOAT_g;
    extern __gshared c_long H5T_NATIVE_DOUBLE_g;
    extern __gshared c_long H5T_NATIVE_LDOUBLE_g;
    extern __gshared c_long H5T_NATIVE_B8_g;
    extern __gshared c_long H5T_NATIVE_B16_g;
    extern __gshared c_long H5T_NATIVE_B32_g;
    extern __gshared c_long H5T_NATIVE_B64_g;
    extern __gshared c_long H5T_NATIVE_OPAQUE_g;
    extern __gshared c_long H5T_NATIVE_HADDR_g;
    extern __gshared c_long H5T_NATIVE_HSIZE_g;
    extern __gshared c_long H5T_NATIVE_HSSIZE_g;
    extern __gshared c_long H5T_NATIVE_HERR_g;
    extern __gshared c_long H5T_NATIVE_HBOOL_g;
    extern __gshared c_long H5T_NATIVE_INT8_g;
    extern __gshared c_long H5T_NATIVE_UINT8_g;
    extern __gshared c_long H5T_NATIVE_INT_LEAST8_g;
    extern __gshared c_long H5T_NATIVE_UINT_LEAST8_g;
    extern __gshared c_long H5T_NATIVE_INT_FAST8_g;
    extern __gshared c_long H5T_NATIVE_UINT_FAST8_g;
    extern __gshared c_long H5T_NATIVE_INT16_g;
    extern __gshared c_long H5T_NATIVE_UINT16_g;
    extern __gshared c_long H5T_NATIVE_INT_LEAST16_g;
    extern __gshared c_long H5T_NATIVE_UINT_LEAST16_g;
    extern __gshared c_long H5T_NATIVE_INT_FAST16_g;
    extern __gshared c_long H5T_NATIVE_UINT_FAST16_g;
    extern __gshared c_long H5T_NATIVE_INT32_g;
    extern __gshared c_long H5T_NATIVE_UINT32_g;
    extern __gshared c_long H5T_NATIVE_INT_LEAST32_g;
    extern __gshared c_long H5T_NATIVE_UINT_LEAST32_g;
    extern __gshared c_long H5T_NATIVE_INT_FAST32_g;
    extern __gshared c_long H5T_NATIVE_UINT_FAST32_g;
    extern __gshared c_long H5T_NATIVE_INT64_g;
    extern __gshared c_long H5T_NATIVE_UINT64_g;
    extern __gshared c_long H5T_NATIVE_INT_LEAST64_g;
    extern __gshared c_long H5T_NATIVE_UINT_LEAST64_g;
    extern __gshared c_long H5T_NATIVE_INT_FAST64_g;
    extern __gshared c_long H5T_NATIVE_UINT_FAST64_g;
    c_long H5Tcreate(H5T_class_t, c_ulong) @nogc nothrow;
    c_long H5Tcopy(c_long) @nogc nothrow;
    int H5Tclose(c_long) @nogc nothrow;
    int H5Tequal(c_long, c_long) @nogc nothrow;
    int H5Tlock(c_long) @nogc nothrow;
    int H5Tcommit2(c_long, const(char)*, c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Topen2(c_long, const(char)*, c_long) @nogc nothrow;
    int H5Tcommit_anon(c_long, c_long, c_long, c_long) @nogc nothrow;
    c_long H5Tget_create_plist(c_long) @nogc nothrow;
    int H5Tcommitted(c_long) @nogc nothrow;
    int H5Tencode(c_long, void*, c_ulong*) @nogc nothrow;
    c_long H5Tdecode(const(void)*) @nogc nothrow;
    int H5Tflush(c_long) @nogc nothrow;
    int H5Trefresh(c_long) @nogc nothrow;
    int H5Tinsert(c_long, const(char)*, c_ulong, c_long) @nogc nothrow;
    int H5Tpack(c_long) @nogc nothrow;
    c_long H5Tenum_create(c_long) @nogc nothrow;
    int H5Tenum_insert(c_long, const(char)*, const(void)*) @nogc nothrow;
    int H5Tenum_nameof(c_long, const(void)*, char*, c_ulong) @nogc nothrow;
    int H5Tenum_valueof(c_long, const(char)*, void*) @nogc nothrow;
    c_long H5Tvlen_create(c_long) @nogc nothrow;
    c_long H5Tarray_create2(c_long, uint, const(ulong)*) @nogc nothrow;
    int H5Tget_array_ndims(c_long) @nogc nothrow;
    int H5Tget_array_dims2(c_long, ulong*) @nogc nothrow;
    int H5Tset_tag(c_long, const(char)*) @nogc nothrow;
    char* H5Tget_tag(c_long) @nogc nothrow;
    c_long H5Tget_super(c_long) @nogc nothrow;
    H5T_class_t H5Tget_class(c_long) @nogc nothrow;
    int H5Tdetect_class(c_long, H5T_class_t) @nogc nothrow;
    c_ulong H5Tget_size(c_long) @nogc nothrow;
    H5T_order_t H5Tget_order(c_long) @nogc nothrow;
    c_ulong H5Tget_precision(c_long) @nogc nothrow;
    int H5Tget_offset(c_long) @nogc nothrow;
    int H5Tget_pad(c_long, H5T_pad_t*, H5T_pad_t*) @nogc nothrow;
    H5T_sign_t H5Tget_sign(c_long) @nogc nothrow;
    int H5Tget_fields(c_long, c_ulong*, c_ulong*, c_ulong*, c_ulong*, c_ulong*) @nogc nothrow;
    c_ulong H5Tget_ebias(c_long) @nogc nothrow;
    H5T_norm_t H5Tget_norm(c_long) @nogc nothrow;
    H5T_pad_t H5Tget_inpad(c_long) @nogc nothrow;
    H5T_str_t H5Tget_strpad(c_long) @nogc nothrow;
    int H5Tget_nmembers(c_long) @nogc nothrow;
    char* H5Tget_member_name(c_long, uint) @nogc nothrow;
    int H5Tget_member_index(c_long, const(char)*) @nogc nothrow;
    c_ulong H5Tget_member_offset(c_long, uint) @nogc nothrow;
    H5T_class_t H5Tget_member_class(c_long, uint) @nogc nothrow;
    c_long H5Tget_member_type(c_long, uint) @nogc nothrow;
    int H5Tget_member_value(c_long, uint, void*) @nogc nothrow;
    H5T_cset_t H5Tget_cset(c_long) @nogc nothrow;
    int H5Tis_variable_str(c_long) @nogc nothrow;
    c_long H5Tget_native_type(c_long, H5T_direction_t) @nogc nothrow;
    int H5Tset_size(c_long, c_ulong) @nogc nothrow;
    int H5Tset_order(c_long, H5T_order_t) @nogc nothrow;
    int H5Tset_precision(c_long, c_ulong) @nogc nothrow;
    int H5Tset_offset(c_long, c_ulong) @nogc nothrow;
    int H5Tset_pad(c_long, H5T_pad_t, H5T_pad_t) @nogc nothrow;
    int H5Tset_sign(c_long, H5T_sign_t) @nogc nothrow;
    int H5Tset_fields(c_long, c_ulong, c_ulong, c_ulong, c_ulong, c_ulong) @nogc nothrow;
    int H5Tset_ebias(c_long, c_ulong) @nogc nothrow;
    int H5Tset_norm(c_long, H5T_norm_t) @nogc nothrow;
    int H5Tset_inpad(c_long, H5T_pad_t) @nogc nothrow;
    int H5Tset_cset(c_long, H5T_cset_t) @nogc nothrow;
    int H5Tset_strpad(c_long, H5T_str_t) @nogc nothrow;
    int H5Tregister(H5T_pers_t, const(char)*, c_long, c_long, int function(c_long, c_long, H5T_cdata_t*, c_ulong, c_ulong, c_ulong, void*, void*, c_long)) @nogc nothrow;
    int H5Tunregister(H5T_pers_t, const(char)*, c_long, c_long, int function(c_long, c_long, H5T_cdata_t*, c_ulong, c_ulong, c_ulong, void*, void*, c_long)) @nogc nothrow;
    int function(c_long, c_long, H5T_cdata_t*, c_ulong, c_ulong, c_ulong, void*, void*, c_long) H5Tfind(c_long, c_long, H5T_cdata_t**) @nogc nothrow;
    int H5Tcompiler_conv(c_long, c_long) @nogc nothrow;
    int H5Tconvert(c_long, c_long, c_ulong, void*, void*, c_long) @nogc nothrow;
    int H5Tcommit1(c_long, const(char)*, c_long) @nogc nothrow;
    c_long H5Topen1(c_long, const(char)*) @nogc nothrow;
    c_long H5Tarray_create1(c_long, int, const(ulong)*, const(int)*) @nogc nothrow;
    int H5Tget_array_dims1(c_long, ulong*, int*) @nogc nothrow;
    alias H5Z_filter_t = int;
    enum H5Z_SO_scale_type_t
    {
        H5Z_SO_FLOAT_DSCALE = 0,
        H5Z_SO_FLOAT_ESCALE = 1,
        H5Z_SO_INT = 2,
    }
    enum H5Z_SO_FLOAT_DSCALE = H5Z_SO_scale_type_t.H5Z_SO_FLOAT_DSCALE;
    enum H5Z_SO_FLOAT_ESCALE = H5Z_SO_scale_type_t.H5Z_SO_FLOAT_ESCALE;
    enum H5Z_SO_INT = H5Z_SO_scale_type_t.H5Z_SO_INT;
    enum H5Z_EDC_t
    {
        H5Z_ERROR_EDC = -1,
        H5Z_DISABLE_EDC = 0,
        H5Z_ENABLE_EDC = 1,
        H5Z_NO_EDC = 2,
    }
    enum H5Z_ERROR_EDC = H5Z_EDC_t.H5Z_ERROR_EDC;
    enum H5Z_DISABLE_EDC = H5Z_EDC_t.H5Z_DISABLE_EDC;
    enum H5Z_ENABLE_EDC = H5Z_EDC_t.H5Z_ENABLE_EDC;
    enum H5Z_NO_EDC = H5Z_EDC_t.H5Z_NO_EDC;
    enum H5Z_cb_return_t
    {
        H5Z_CB_ERROR = -1,
        H5Z_CB_FAIL = 0,
        H5Z_CB_CONT = 1,
        H5Z_CB_NO = 2,
    }
    enum H5Z_CB_ERROR = H5Z_cb_return_t.H5Z_CB_ERROR;
    enum H5Z_CB_FAIL = H5Z_cb_return_t.H5Z_CB_FAIL;
    enum H5Z_CB_CONT = H5Z_cb_return_t.H5Z_CB_CONT;
    enum H5Z_CB_NO = H5Z_cb_return_t.H5Z_CB_NO;
    alias H5Z_filter_func_t = H5Z_cb_return_t function(int, void*, c_ulong, void*);
    struct H5Z_cb_t
    {
        @DppOffsetSize(0,8) H5Z_cb_return_t function(int, void*, c_ulong, void*) func;
        @DppOffsetSize(8,8) void* op_data;
    }
    alias H5Z_can_apply_func_t = int function(c_long, c_long, c_long);
    alias H5Z_set_local_func_t = int function(c_long, c_long, c_long);
    alias H5Z_func_t = c_ulong function(uint, c_ulong, const(uint)*, c_ulong, c_ulong*, void**);
    struct H5Z_class2_t
    {
        @DppOffsetSize(0,4) int version_;
        @DppOffsetSize(4,4) int id;
        @DppOffsetSize(8,4) uint encoder_present;
        @DppOffsetSize(12,4) uint decoder_present;
        @DppOffsetSize(16,8) const(char)* name;
        @DppOffsetSize(24,8) int function(c_long, c_long, c_long) can_apply;
        @DppOffsetSize(32,8) int function(c_long, c_long, c_long) set_local;
        @DppOffsetSize(40,8) c_ulong function(uint, c_ulong, const(uint)[0], c_ulong, c_ulong*, void**) filter;
    }
    int H5Zregister(const(void)*) @nogc nothrow;
    int H5Zunregister(int) @nogc nothrow;
    int H5Zfilter_avail(int) @nogc nothrow;
    int H5Zget_filter_info(int, uint*) @nogc nothrow;
    struct H5Z_class1_t
    {
        @DppOffsetSize(0,4) int id;
        @DppOffsetSize(8,8) const(char)* name;
        @DppOffsetSize(16,8) int function(c_long, c_long, c_long) can_apply;
        @DppOffsetSize(24,8) int function(c_long, c_long, c_long) set_local;
        @DppOffsetSize(32,8) c_ulong function(uint, c_ulong, const(uint)[0], c_ulong, c_ulong*, void**) filter;
    }
    void* H5resize_memory(void*, c_ulong) @nogc nothrow;
    void* H5allocate_memory(c_ulong, bool) @nogc nothrow;
    int H5free_memory(void*) @nogc nothrow;
    int H5is_library_threadsafe(bool*) @nogc nothrow;
    int H5check_version(uint, uint, uint) @nogc nothrow;
    int H5get_libversion(uint*, uint*, uint*) @nogc nothrow;
    int H5set_free_list_limits(int, int, int, int, int, int) @nogc nothrow;
    int H5garbage_collect() @nogc nothrow;
    int H5dont_atexit() @nogc nothrow;
    int H5close() @nogc nothrow;
    int H5open() @nogc nothrow;
    struct H5_ih_info_t
    {
        @DppOffsetSize(0,8) ulong index_size;
        @DppOffsetSize(8,8) ulong heap_size;
    }
    enum H5_index_t
    {
        H5_INDEX_UNKNOWN = -1,
        H5_INDEX_NAME = 0,
        H5_INDEX_CRT_ORDER = 1,
        H5_INDEX_N = 2,
    }
    enum H5_INDEX_UNKNOWN = H5_index_t.H5_INDEX_UNKNOWN;
    enum H5_INDEX_NAME = H5_index_t.H5_INDEX_NAME;
    enum H5_INDEX_CRT_ORDER = H5_index_t.H5_INDEX_CRT_ORDER;
    enum H5_INDEX_N = H5_index_t.H5_INDEX_N;
    enum _Anonymous_18
    {
        H5_ITER_UNKNOWN = -1,
        H5_ITER_INC = 0,
        H5_ITER_DEC = 1,
        H5_ITER_NATIVE = 2,
        H5_ITER_N = 3,
    }
    enum H5_ITER_UNKNOWN = _Anonymous_18.H5_ITER_UNKNOWN;
    enum H5_ITER_INC = _Anonymous_18.H5_ITER_INC;
    enum H5_ITER_DEC = _Anonymous_18.H5_ITER_DEC;
    enum H5_ITER_NATIVE = _Anonymous_18.H5_ITER_NATIVE;
    enum H5_ITER_N = _Anonymous_18.H5_ITER_N;
    alias H5_iter_order_t = _Anonymous_18;
    alias haddr_t = c_ulong;
    alias hssize_t = long;
    alias hsize_t = ulong;
    alias htri_t = int;
    alias hbool_t = bool;
    alias herr_t = int;


    enum DPP_ENUM_H5_HAVE_SIGNAL = 1;


    enum DPP_ENUM_H5_HAVE_SIGPROCMASK = 1;


    enum DPP_ENUM_H5_HAVE_SNPRINTF = 1;


    enum DPP_ENUM_H5_HAVE_SRANDOM = 1;


    enum DPP_ENUM_H5_HAVE_STDBOOL_H = 1;


    enum DPP_ENUM_H5_HAVE_STDDEF_H = 1;


    enum DPP_ENUM_H5_HAVE_STDINT_H = 1;


    enum DPP_ENUM_H5_HAVE_STDLIB_H = 1;


    enum DPP_ENUM_H5_HAVE_STRDUP = 1;


    enum DPP_ENUM_H5_HAVE_STRINGS_H = 1;


    enum DPP_ENUM_H5_HAVE_STRING_H = 1;


    enum DPP_ENUM_H5_HAVE_STRTOLL = 1;


    enum DPP_ENUM_H5_HAVE_STRTOULL = 1;


    enum DPP_ENUM_H5_HAVE_SYMLINK = 1;


    enum DPP_ENUM_H5_HAVE_SYSTEM = 1;


    enum DPP_ENUM_H5_HAVE_SYS_FILE_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_IOCTL_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_RESOURCE_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_SOCKET_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_STAT_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_TIMEB_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_TIME_H = 1;


    enum DPP_ENUM_H5_HAVE_SYS_TYPES_H = 1;


    enum DPP_ENUM_H5_HAVE_SZLIB_H = 1;


    enum DPP_ENUM_H5_HAVE_TIMEZONE = 1;


    enum DPP_ENUM_H5_HAVE_TIOCGETD = 1;


    enum DPP_ENUM_H5_HAVE_TIOCGWINSZ = 1;


    enum DPP_ENUM_H5_HAVE_TMPFILE = 1;


    enum DPP_ENUM_H5_HAVE_TM_GMTOFF = 1;


    enum DPP_ENUM_H5_HAVE_UNISTD_H = 1;


    enum DPP_ENUM_H5_HAVE_VASPRINTF = 1;


    enum DPP_ENUM_H5_HAVE_VSNPRINTF = 1;


    enum DPP_ENUM_H5_HAVE_WAITPID = 1;


    enum DPP_ENUM_H5_HAVE_ZLIB_H = 1;


    enum DPP_ENUM_H5_HAVE___INLINE = 1;


    enum DPP_ENUM_H5_HAVE___INLINE__ = 1;


    enum DPP_ENUM_H5_INCLUDE_HL = 1;


    enum DPP_ENUM_H5_LDOUBLE_TO_LLONG_ACCURATE = 1;


    enum DPP_ENUM_H5_LLONG_TO_LDOUBLE_CORRECT = 1;




    enum DPP_ENUM_H5_NO_ALIGNMENT_RESTRICTIONS = 1;
    enum DPP_ENUM_H5_PAC_C_MAX_REAL_PRECISION = 33;


    enum DPP_ENUM_H5_PAC_FC_MAX_REAL_PRECISION = 33;




    enum DPP_ENUM_H5_SIZEOF_BOOL = 1;


    enum DPP_ENUM_H5_SIZEOF_CHAR = 1;


    enum DPP_ENUM_H5_SIZEOF_DOUBLE = 8;


    enum DPP_ENUM_H5_SIZEOF_FLOAT = 4;


    enum DPP_ENUM_H5_SIZEOF_INT = 4;


    enum DPP_ENUM_H5_SIZEOF_INT16_T = 2;


    enum DPP_ENUM_H5_SIZEOF_INT32_T = 4;


    enum DPP_ENUM_H5_SIZEOF_INT64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_INT8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_INT_FAST16_T = 8;


    enum DPP_ENUM_H5_SIZEOF_INT_FAST32_T = 8;


    enum DPP_ENUM_H5_SIZEOF_INT_FAST64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_INT_FAST8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_INT_LEAST16_T = 2;


    enum DPP_ENUM_H5_SIZEOF_INT_LEAST32_T = 4;


    enum DPP_ENUM_H5_SIZEOF_INT_LEAST64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_INT_LEAST8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_LONG = 8;


    enum DPP_ENUM_H5_SIZEOF_LONG_DOUBLE = 16;


    enum DPP_ENUM_H5_SIZEOF_LONG_LONG = 8;


    enum DPP_ENUM_H5_SIZEOF_OFF_T = 8;


    enum DPP_ENUM_H5_SIZEOF_PTRDIFF_T = 8;


    enum DPP_ENUM_H5_SIZEOF_SHORT = 2;


    enum DPP_ENUM_H5_SIZEOF_SIZE_T = 8;


    enum DPP_ENUM_H5_SIZEOF_SSIZE_T = 8;


    enum DPP_ENUM_H5_SIZEOF_TIME_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT16_T = 2;


    enum DPP_ENUM_H5_SIZEOF_UINT32_T = 4;


    enum DPP_ENUM_H5_SIZEOF_UINT64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_UINT_FAST16_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT_FAST32_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT_FAST64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT_FAST8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_UINT_LEAST16_T = 2;


    enum DPP_ENUM_H5_SIZEOF_UINT_LEAST32_T = 4;


    enum DPP_ENUM_H5_SIZEOF_UINT_LEAST64_T = 8;


    enum DPP_ENUM_H5_SIZEOF_UINT_LEAST8_T = 1;


    enum DPP_ENUM_H5_SIZEOF_UNSIGNED = 4;


    enum DPP_ENUM_H5_SIZEOF__QUAD = 0;


    enum DPP_ENUM_H5_SIZEOF___FLOAT128 = 16;


    enum DPP_ENUM_H5_SIZEOF___INT64 = 0;


    enum DPP_ENUM_H5_STDC_HEADERS = 1;


    enum DPP_ENUM_H5_TIME_WITH_SYS_TIME = 1;


    enum DPP_ENUM_H5_USE_110_API_DEFAULT = 1;




    enum DPP_ENUM_H5_WANT_DATA_ACCURACY = 1;


    enum DPP_ENUM_H5_WANT_DCONV_EXCEPTION = 1;




    enum DPP_ENUM_H5_HAVE_SIGLONGJMP = 1;


    enum DPP_ENUM_H5_HAVE_SETJMP_H = 1;


    enum DPP_ENUM_H5_HAVE_SETJMP = 1;


    enum DPP_ENUM_H5_HAVE_ROUNDF = 1;


    enum DPP_ENUM_H5_HAVE_ROUND = 1;


    enum DPP_ENUM_H5_HAVE_RAND_R = 1;


    enum DPP_ENUM_H5_HAVE_RANDOM = 1;


    enum DPP_ENUM_H5_HAVE_QUADMATH_H = 1;


    enum DPP_ENUM_H5_HAVE_PREADWRITE = 1;


    enum DPP_ENUM_H5_HAVE_MEMORY_H = 1;


    enum DPP_ENUM_H5_HAVE_LSTAT = 1;


    enum DPP_ENUM_H5_HAVE_LROUNDF = 1;


    enum DPP_ENUM_H5_HAVE_LROUND = 1;


    enum DPP_ENUM_H5_HAVE_LONGJMP = 1;


    enum DPP_ENUM_H5_HAVE_LLROUNDF = 1;


    enum DPP_ENUM_H5_HAVE_LLROUND = 1;


    enum DPP_ENUM_H5_HAVE_LIBZ = 1;


    enum DPP_ENUM_H5_HAVE_LIBSZ = 1;






    enum DPP_ENUM_H5_VERS_MAJOR = 1;


    enum DPP_ENUM_H5_VERS_MINOR = 10;


    enum DPP_ENUM_H5_VERS_RELEASE = 5;
    enum DPP_ENUM_H5_HAVE_LIBM = 1;


    enum DPP_ENUM_H5_HAVE_LIBDL = 1;


    enum DPP_ENUM_H5_HAVE_IOCTL = 1;


    enum DPP_ENUM_H5_HAVE_INTTYPES_H = 1;


    enum DPP_ENUM_H5_HAVE_INLINE = 1;


    enum DPP_ENUM_H5_HAVE_GETTIMEOFDAY = 1;


    enum DPP_ENUM_H5_HAVE_GETRUSAGE = 1;


    enum DPP_ENUM_H5_HAVE_GETPWUID = 1;


    enum DPP_ENUM_H5_HAVE_GETHOSTNAME = 1;


    enum DPP_ENUM_H5_HAVE_Fortran_INTEGER_SIZEOF_16 = 1;


    enum DPP_ENUM_H5_HAVE_FUNCTION = 1;


    enum DPP_ENUM_H5_HAVE_FREXPL = 1;
    enum DPP_ENUM_H5_HAVE_FREXPF = 1;


    enum DPP_ENUM_H5_HAVE_FORK = 1;


    enum DPP_ENUM_H5_HAVE_FLOCK = 1;






    enum DPP_ENUM_H5_HAVE_FLOAT128 = 1;


    enum DPP_ENUM_H5_HAVE_FILTER_SZIP = 1;


    enum DPP_ENUM_H5_HAVE_FILTER_DEFLATE = 1;


    enum DPP_ENUM_H5_HAVE_FEATURES_H = 1;






    enum DPP_ENUM_H5_HAVE_FCNTL = 1;


    enum DPP_ENUM_H5_HAVE_EMBEDDED_LIBINFO = 1;


    enum DPP_ENUM_H5_HAVE_DLFCN_H = 1;


    enum DPP_ENUM_H5_HAVE_DIRENT_H = 1;


    enum DPP_ENUM_H5_HAVE_DIFFTIME = 1;
    enum DPP_ENUM_H5_HAVE_CLOCK_GETTIME = 1;


    enum DPP_ENUM_H5_HAVE_C99_FUNC = 1;


    enum DPP_ENUM_H5_HAVE_C99_DESIGNATED_INITIALIZER = 1;


    enum DPP_ENUM_H5_HAVE_ATTRIBUTE = 1;


    enum DPP_ENUM_H5_HAVE_ASPRINTF = 1;


    enum DPP_ENUM_H5_HAVE_ALARM = 1;
    enum DPP_ENUM_H5_FORTRAN_HAVE_STORAGE_SIZE = 1;


    enum DPP_ENUM_H5_FORTRAN_HAVE_SIZEOF = 1;


    enum DPP_ENUM_H5_FORTRAN_HAVE_C_SIZEOF = 1;


    enum DPP_ENUM_H5_FORTRAN_HAVE_C_LONG_DOUBLE = 1;


    enum DPP_ENUM_H5_FORTRAN_C_LONG_DOUBLE_IS_UNIQUE = 1;






    enum DPP_ENUM_H5_DEV_T_IS_SCALAR = 1;




    enum DPP_ENUM_H5_CXX_HAVE_OFFSETOF = 1;
    enum DPP_ENUM_H5_USE_110_API = 1;




    enum DPP_ENUM_H5Acreate_vers = 2;


    enum DPP_ENUM_H5Aiterate_vers = 2;


    enum DPP_ENUM_H5Dcreate_vers = 2;


    enum DPP_ENUM_H5Dopen_vers = 2;


    enum DPP_ENUM_H5Eclear_vers = 2;


    enum DPP_ENUM_H5Eget_auto_vers = 2;


    enum DPP_ENUM_H5Eprint_vers = 2;


    enum DPP_ENUM_H5Epush_vers = 2;


    enum DPP_ENUM_H5Eset_auto_vers = 2;


    enum DPP_ENUM_H5Ewalk_vers = 2;


    enum DPP_ENUM_H5Fget_info_vers = 2;


    enum DPP_ENUM_H5Gcreate_vers = 2;


    enum DPP_ENUM_H5Gopen_vers = 2;


    enum DPP_ENUM_H5Pget_filter_vers = 2;


    enum DPP_ENUM_H5Pget_filter_by_id_vers = 2;


    enum DPP_ENUM_H5Pinsert_vers = 2;


    enum DPP_ENUM_H5Pregister_vers = 2;


    enum DPP_ENUM_H5Rdereference_vers = 2;


    enum DPP_ENUM_H5Rget_obj_type_vers = 2;


    enum DPP_ENUM_H5Tarray_create_vers = 2;


    enum DPP_ENUM_H5Tcommit_vers = 2;


    enum DPP_ENUM_H5Tget_array_dims_vers = 2;


    enum DPP_ENUM_H5Topen_vers = 2;


    enum DPP_ENUM_H5E_auto_t_vers = 2;


    enum DPP_ENUM_H5Z_class_t_vers = 2;
    enum DPP_ENUM_H5Z_SO_INT_MINBITS_DEFAULT = 0;




    enum DPP_ENUM_H5Z_SCALEOFFSET_USER_NPARMS = 2;


    enum DPP_ENUM_H5Z_NBIT_USER_NPARMS = 0;


    enum DPP_ENUM_H5Z_SZIP_PARM_PPS = 3;




    enum DPP_ENUM_H5Z_SZIP_PARM_BPP = 2;


    enum DPP_ENUM_H5Z_SZIP_PARM_PPB = 1;


    enum DPP_ENUM_H5Z_SZIP_PARM_MASK = 0;




    enum DPP_ENUM_H5Z_SZIP_TOTAL_NPARMS = 4;


    enum DPP_ENUM_H5Z_SZIP_USER_NPARMS = 2;


    enum DPP_ENUM_H5Z_SHUFFLE_TOTAL_NPARMS = 1;




    enum DPP_ENUM_H5Z_SHUFFLE_USER_NPARMS = 0;


    enum DPP_ENUM_H5_SZIP_MAX_PIXELS_PER_BLOCK = 32;


    enum DPP_ENUM_H5_SZIP_NN_OPTION_MASK = 32;
    enum DPP_ENUM_H5_SZIP_EC_OPTION_MASK = 4;


    enum DPP_ENUM_H5_SZIP_CHIP_OPTION_MASK = 2;


    enum DPP_ENUM_H5_SZIP_ALLOW_K13_OPTION_MASK = 1;
    enum DPP_ENUM_H5Z_MAX_NFILTERS = 32;


    enum DPP_ENUM_H5Z_FILTER_ALL = 0;


    enum DPP_ENUM_H5Z_FILTER_MAX = 65535;




    enum DPP_ENUM_H5Z_FILTER_RESERVED = 256;


    enum DPP_ENUM_H5Z_FILTER_SCALEOFFSET = 6;


    enum DPP_ENUM_H5Z_FILTER_NBIT = 5;




    enum DPP_ENUM_H5Z_FILTER_SZIP = 4;


    enum DPP_ENUM_H5Z_FILTER_FLETCHER32 = 3;


    enum DPP_ENUM_H5Z_FILTER_SHUFFLE = 2;




    enum DPP_ENUM_H5Z_FILTER_DEFLATE = 1;


    enum DPP_ENUM_H5Z_FILTER_NONE = 0;
    enum DPP_ENUM__BITS_BYTESWAP_H = 1;
    enum DPP_ENUM___GLIBC_USE_LIB_EXT2 = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_BFP_EXT = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_FUNCS_EXT = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_TYPES_EXT = 0;
    enum DPP_ENUM__POSIX_THREAD_KEYS_MAX = 128;


    enum DPP_ENUM_PTHREAD_KEYS_MAX = 1024;


    enum DPP_ENUM__POSIX_THREAD_DESTRUCTOR_ITERATIONS = 4;




    enum DPP_ENUM__POSIX_THREAD_THREADS_MAX = 64;


    enum DPP_ENUM_AIO_PRIO_DELTA_MAX = 20;


    enum DPP_ENUM_PTHREAD_STACK_MIN = 16384;


    enum DPP_ENUM_DELAYTIMER_MAX = 2147483647;


    enum DPP_ENUM_TTY_NAME_MAX = 32;


    enum DPP_ENUM_LOGIN_NAME_MAX = 256;


    enum DPP_ENUM_HOST_NAME_MAX = 64;


    enum DPP_ENUM_MQ_PRIO_MAX = 32768;




    enum DPP_ENUM__BITS_POSIX1_LIM_H = 1;




    enum DPP_ENUM__POSIX_AIO_LISTIO_MAX = 2;


    enum DPP_ENUM__POSIX_AIO_MAX = 1;


    enum DPP_ENUM__POSIX_ARG_MAX = 4096;




    enum DPP_ENUM__POSIX_CHILD_MAX = 25;


    enum DPP_ENUM__POSIX_DELAYTIMER_MAX = 32;


    enum DPP_ENUM__POSIX_HOST_NAME_MAX = 255;


    enum DPP_ENUM__POSIX_LINK_MAX = 8;


    enum DPP_ENUM__POSIX_LOGIN_NAME_MAX = 9;


    enum DPP_ENUM__POSIX_MAX_CANON = 255;


    enum DPP_ENUM__POSIX_MAX_INPUT = 255;


    enum DPP_ENUM__POSIX_MQ_OPEN_MAX = 8;


    enum DPP_ENUM__POSIX_MQ_PRIO_MAX = 32;


    enum DPP_ENUM__POSIX_NAME_MAX = 14;




    enum DPP_ENUM__POSIX_NGROUPS_MAX = 8;




    enum DPP_ENUM__POSIX_OPEN_MAX = 20;




    enum DPP_ENUM__POSIX_PATH_MAX = 256;


    enum DPP_ENUM__POSIX_PIPE_BUF = 512;


    enum DPP_ENUM__POSIX_RE_DUP_MAX = 255;


    enum DPP_ENUM__POSIX_RTSIG_MAX = 8;


    enum DPP_ENUM__POSIX_SEM_NSEMS_MAX = 256;


    enum DPP_ENUM__POSIX_SEM_VALUE_MAX = 32767;


    enum DPP_ENUM__POSIX_SIGQUEUE_MAX = 32;


    enum DPP_ENUM__POSIX_SSIZE_MAX = 32767;


    enum DPP_ENUM__POSIX_STREAM_MAX = 8;


    enum DPP_ENUM__POSIX_SYMLINK_MAX = 255;


    enum DPP_ENUM__POSIX_SYMLOOP_MAX = 8;


    enum DPP_ENUM__POSIX_TIMER_MAX = 32;


    enum DPP_ENUM__POSIX_TTY_NAME_MAX = 9;




    enum DPP_ENUM__POSIX_TZNAME_MAX = 6;




    enum DPP_ENUM__POSIX_CLOCKRES_MIN = 20000000;
    enum DPP_ENUM__BITS_POSIX2_LIM_H = 1;


    enum DPP_ENUM__POSIX2_BC_BASE_MAX = 99;


    enum DPP_ENUM__POSIX2_BC_DIM_MAX = 2048;


    enum DPP_ENUM__POSIX2_BC_SCALE_MAX = 99;


    enum DPP_ENUM__POSIX2_BC_STRING_MAX = 1000;


    enum DPP_ENUM__POSIX2_COLL_WEIGHTS_MAX = 2;


    enum DPP_ENUM__POSIX2_EXPR_NEST_MAX = 32;


    enum DPP_ENUM__POSIX2_LINE_MAX = 2048;


    enum DPP_ENUM__POSIX2_RE_DUP_MAX = 255;


    enum DPP_ENUM__POSIX2_CHARCLASS_NAME_MAX = 14;
    enum DPP_ENUM_COLL_WEIGHTS_MAX = 255;






    enum DPP_ENUM_CHARCLASS_NAME_MAX = 2048;




    enum DPP_ENUM__BITS_PTHREADTYPES_ARCH_H = 1;
    enum DPP_ENUM___SIZEOF_PTHREAD_MUTEX_T = 40;


    enum DPP_ENUM___SIZEOF_PTHREAD_ATTR_T = 56;


    enum DPP_ENUM___SIZEOF_PTHREAD_RWLOCK_T = 56;


    enum DPP_ENUM___SIZEOF_PTHREAD_BARRIER_T = 32;


    enum DPP_ENUM___SIZEOF_PTHREAD_MUTEXATTR_T = 4;


    enum DPP_ENUM___SIZEOF_PTHREAD_COND_T = 48;


    enum DPP_ENUM___SIZEOF_PTHREAD_CONDATTR_T = 4;


    enum DPP_ENUM___SIZEOF_PTHREAD_RWLOCKATTR_T = 8;


    enum DPP_ENUM___SIZEOF_PTHREAD_BARRIERATTR_T = 4;






    enum DPP_ENUM___PTHREAD_MUTEX_LOCK_ELISION = 1;




    enum DPP_ENUM___PTHREAD_MUTEX_NUSERS_AFTER_KIND = 0;


    enum DPP_ENUM___PTHREAD_MUTEX_USE_UNION = 0;
    enum DPP_ENUM___PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;




    enum DPP_ENUM__BITS_PTHREADTYPES_COMMON_H = 1;
    enum DPP_ENUM___have_pthread_attr_t = 1;
    enum DPP_ENUM__BITS_STDINT_INTN_H = 1;
    enum DPP_ENUM__BITS_STDINT_UINTN_H = 1;
    enum DPP_ENUM__BITS_STDIO_LIM_H = 1;




    enum DPP_ENUM_L_tmpnam = 20;


    enum DPP_ENUM_TMP_MAX = 238328;


    enum DPP_ENUM_FILENAME_MAX = 4096;




    enum DPP_ENUM_L_ctermid = 9;




    enum DPP_ENUM_FOPEN_MAX = 16;
    enum DPP_ENUM__THREAD_SHARED_TYPES_H = 1;
    enum DPP_ENUM_H5T_OPAQUE_TAG_MAX = 256;
    enum DPP_ENUM___PTHREAD_MUTEX_HAVE_PREV = 1;






    enum DPP_ENUM_H5S_MAX_RANK = 32;


    enum DPP_ENUM__BITS_TYPES_H = 1;
    enum DPP_ENUM_H5O_SHMESG_MAX_LIST_SIZE = 5000;


    enum DPP_ENUM_H5O_SHMESG_MAX_NINDEXES = 8;
    enum DPP_ENUM_H5L_LINK_CLASS_T_VERS_0 = 0;


    enum DPP_ENUM_H5L_LINK_CLASS_T_VERS = 1;
    enum DPP_ENUM_H5G_NLIBTYPES = 8;


    enum DPP_ENUM_H5G_NTYPES = 256;
    enum DPP_ENUM_H5F_NUM_METADATA_READ_RETRY_TYPES = 21;
    enum DPP_ENUM___FILE_defined = 1;




    enum DPP_ENUM_____FILE_defined = 1;






    enum DPP_ENUM______fpos64_t_defined = 1;
    enum DPP_ENUM______fpos_t_defined = 1;
    enum DPP_ENUM_____mbstate_t_defined = 1;
    enum DPP_ENUM___clock_t_defined = 1;






    enum DPP_ENUM___clockid_t_defined = 1;






    enum DPP_ENUM___sigset_t_defined = 1;






    enum DPP_ENUM___struct_FILE_defined = 1;
    enum DPP_ENUM__STRUCT_TIMESPEC = 1;




    enum DPP_ENUM_H5FD_VFD_DEFAULT = 0;


    enum DPP_ENUM___timeval_defined = 1;


    enum DPP_ENUM_H5_HAVE_VFL = 1;




    enum DPP_ENUM___time_t_defined = 1;






    enum DPP_ENUM___timer_t_defined = 1;






    enum DPP_ENUM_H5D_MULTI_CHUNK_IO_COL_THRESHOLD = 60;


    enum DPP_ENUM__BITS_TYPESIZES_H = 1;


    enum DPP_ENUM_H5D_ONE_LINK_CHUNK_IO_THRESHOLD = 0;
    enum DPP_ENUM___OFF_T_MATCHES_OFF64_T = 1;


    enum DPP_ENUM___INO_T_MATCHES_INO64_T = 1;


    enum DPP_ENUM___RLIM_T_MATCHES_RLIM64_T = 1;


    enum DPP_ENUM___FD_SETSIZE = 1024;




    enum DPP_ENUM__BITS_UINTN_IDENTITY_H = 1;
    enum DPP_ENUM__BITS_WCHAR_H = 1;
    enum DPP_ENUM___WORDSIZE = 64;
    enum DPP_ENUM___WORDSIZE_TIME64_COMPAT32 = 1;


    enum DPP_ENUM___SYSCALL_WORDSIZE = 64;


    enum DPP_ENUM__ENDIAN_H = 1;




    enum DPP_ENUM___LITTLE_ENDIAN = 1234;


    enum DPP_ENUM___BIG_ENDIAN = 4321;


    enum DPP_ENUM___PDP_ENDIAN = 3412;
    enum DPP_ENUM__FEATURES_H = 1;
    enum DPP_ENUM__DEFAULT_SOURCE = 1;
    enum DPP_ENUM___USE_ISOC11 = 1;
    enum DPP_ENUM___USE_ISOC99 = 1;
    enum DPP_ENUM___USE_ISOC95 = 1;




    enum DPP_ENUM___USE_POSIX_IMPLICITLY = 1;


    enum DPP_ENUM__POSIX_SOURCE = 1;
    enum DPP_ENUM___USE_POSIX = 1;






    enum DPP_ENUM___USE_POSIX2 = 1;






    enum DPP_ENUM___USE_POSIX199309 = 1;






    enum DPP_ENUM___USE_POSIX199506 = 1;






    enum DPP_ENUM___USE_XOPEN2K = 1;






    enum DPP_ENUM___USE_XOPEN2K8 = 1;


    enum DPP_ENUM__ATFILE_SOURCE = 1;




    enum DPP_ENUM___USE_MISC = 1;




    enum DPP_ENUM___USE_ATFILE = 1;


    enum DPP_ENUM___USE_FORTIFY_LEVEL = 0;




    enum DPP_ENUM___GLIBC_USE_DEPRECATED_GETS = 0;




    enum DPP_ENUM___GNU_LIBRARY__ = 6;


    enum DPP_ENUM___GLIBC__ = 2;


    enum DPP_ENUM___GLIBC_MINOR__ = 28;
    enum DPP_ENUM__INTTYPES_H = 1;
    enum DPP_ENUM_____gwchar_t_defined = 1;
    enum DPP_ENUM__LIBC_LIMITS_H_ = 1;






    enum DPP_ENUM_MB_LEN_MAX = 16;
    enum DPP_ENUM_NR_OPEN = 1024;


    enum DPP_ENUM_NGROUPS_MAX = 65536;


    enum DPP_ENUM_ARG_MAX = 131072;


    enum DPP_ENUM_LINK_MAX = 127;


    enum DPP_ENUM_MAX_CANON = 255;


    enum DPP_ENUM_MAX_INPUT = 255;


    enum DPP_ENUM_NAME_MAX = 255;


    enum DPP_ENUM_PATH_MAX = 4096;


    enum DPP_ENUM_PIPE_BUF = 4096;


    enum DPP_ENUM_XATTR_NAME_MAX = 255;


    enum DPP_ENUM_XATTR_SIZE_MAX = 65536;


    enum DPP_ENUM_XATTR_LIST_MAX = 65536;


    enum DPP_ENUM_RTSIG_MAX = 32;


    enum DPP_ENUM__STDC_PREDEF_H = 1;


    enum DPP_ENUM__STDINT_H = 1;
    enum DPP_ENUM__STDIO_H = 1;
    enum DPP_ENUM__IOFBF = 0;


    enum DPP_ENUM__IOLBF = 1;


    enum DPP_ENUM__IONBF = 2;


    enum DPP_ENUM_BUFSIZ = 8192;




    enum DPP_ENUM_SEEK_SET = 0;


    enum DPP_ENUM_SEEK_CUR = 1;


    enum DPP_ENUM_SEEK_END = 2;
    enum DPP_ENUM_H5AC__CACHE_IMAGE__ENTRY_AGEOUT__MAX = 100;


    enum DPP_ENUM_H5AC__CACHE_IMAGE__ENTRY_AGEOUT__NONE = -1;


    enum DPP_ENUM_H5AC__CURR_CACHE_IMAGE_CONFIG_VERSION = 1;


    enum DPP_ENUM_H5AC_METADATA_WRITE_STRATEGY__DISTRIBUTED = 1;


    enum DPP_ENUM_H5AC_METADATA_WRITE_STRATEGY__PROCESS_0_ONLY = 0;


    enum DPP_ENUM_H5AC__MAX_TRACE_FILE_NAME_LEN = 1024;


    enum DPP_ENUM_H5AC__CURR_CACHE_CONFIG_VERSION = 1;




    enum DPP_ENUM__SYS_CDEFS_H = 1;
    enum DPP_ENUM___glibc_c99_flexarr_available = 1;
    enum DPP_ENUM___HAVE_GENERIC_SELECTION = 1;


    enum DPP_ENUM__SYS_SELECT_H = 1;
    enum DPP_ENUM__SYS_TYPES_H = 1;
    enum DPP_ENUM___BIT_TYPES_DEFINED__ = 1;
    enum DPP_ENUM___GNUC_VA_LIST = 1;






    enum DPP_ENUM_true_ = 1;


    enum DPP_ENUM_false_ = 0;


    enum DPP_ENUM___bool_true_false_are_defined = 1;
}
import core.memory:GC;
import std.conv:to;





char** toCPointerArray(string[] inp)
{
 auto ret=cast(char**) GC.calloc((char *).sizeof);
 foreach(i, item;inp)
  *(ret+i)=cast(char*)(to!string(item)~"\0").ptr;
 return ret;
}







/+

struct H5DO
{
 void write_chunk(hidh_t dset_id, hid_t dxpl_id, uint filters, const hsize_t *offset, size_t data_size, const (void*) buf)
 {
  enforce(H5DOwrite_chunk(dset_id,dxpl_id,filters,offset,data_size,buf)
 }
}



 enum DimensionScaleClass = "DIMENSION_SCALE";
 enum DimensionList = "DIMENSION_LIST";
 enum ReferenceList = "REFERENCE_LIST";
 enum DimensionLabels = "DIMENSION_LABELS";

 alias "DIMENSION_SCALE" = DimensionScaleClass;
 alias "DIMENSION_LIST" = DimensionList;
 alias "REFERENCE_LIST" = ReferenceList;
 alias "DIMENSION_LABELS" = DimensionLabels;


 alias H5DS_iterate_t = herr_t function(hid_t dset, unsigned dim, hid_t scale, void *visitor_data);
 herr_t H5DSattach_scale( hid_t did, hid_t dsid, uint idx);
 herr_t H5DSdetach_scale( hid_t did, hid_t dsid, uint idx);
 herr_t H5DSset_scale( hid_t dsid, const (char*) dimname);
 int H5DSget_num_scales( hid_t did, uint dim);
 herr_t H5DSset_label( hid_t did, uint idx, const (char*) label);
 ssize_t H5DSget_label( hid_t did, uint idx, char *label, size_t size);
 ssize_t H5DSget_scale_name( hid_t did, char *name, size_t size);
 htri_t H5DSis_scale( hid_t did);
 herr_t H5DSiterate_scales( hid_t did, uint dim, int *idx, H5DS_iterate_t visitor, void *visitor_data);
 htri_t H5DSis_attached( hid_t did, hid_t dsid, uint idx);




struct H5Image
{


 herr_t H5IMmake_image_8bit( hid_t loc_id, const (char*) dset_name, hsize_t width, hsize_t height, const (ubyte*) buffer );
 herr_t H5IMmake_image_24bit( hid_t loc_id, const (char*) dset_name, hsize_t width, hsize_t height, const (char*) interlace,
  const (ubyte*) buffer );
 herr_t H5IMget_image_info( hid_t loc_id, const (char*) dset_name, hsize_t *width, hsize_t *height, hsize_t *planes, char *interlace,
                      hssize_t *npals );
 herr_t H5IMread_image( hid_t loc_id, const (char*) dset_name, ubyte *buffer );
 herr_t H5IMmake_palette( hid_t loc_id, const (char*) pal_name, const hsize_t *pal_dims, const (ubyte*) pal_data );
 herr_t H5IMlink_palette( hid_t loc_id, const (char*) image_name, const (char*) pal_name );
 herr_t H5IMunlink_palette( hid_t loc_id, const (char*) image_name, const (char*) pal_name );
 herr_t H5IMget_npalettes( hid_t loc_id, const (char*) image_name, hssize_t *npals );
 herr_t H5IMget_palette_info( hid_t loc_id, const (char*) image_name, int pal_number, hsize_t *pal_dims );
 herr_t H5IMget_palette( hid_t loc_id, const (char*) image_name, int pal_number, ubyte *pal_data );
 herr_t H5IMis_image( hid_t loc_id, const (char*) dset_name );
 herr_t H5IMis_palette( hid_t loc_id, const (char*) dset_name );






 enum 0x0001 = 0x0001
 enum 0x0002 = 0x0002;

 enum 0x0004= 0x0004;
 enum 0x0007 = 0x0007;

 enum H5LT_lang_t
 {
     H5LT_LANG_ERR = -1,
     H5LT_DDL = 0,
     H5LT_C = 1,
     H5LT_FORTRAN = 2,
     H5LT_NO_LANG = 3
 }







struct H5Lite
{
 void make(T)(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in T[] data)
 {
  enforce(H5LTmake_dataset(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,typeID,data.ptr)>=0,
   new Exception("H5Lite.make error"));
 }

 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in char[] data)
 {
  enforce(H5LTmake_dataset_char(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!char error"));
 }

 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in short[] data)
 {
  enforce(H5LTmake_dataset_short(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!short error"));
 }

 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in int[] data)
 {
  enforce(H5LTmake_dataset_int(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!int error"));
 }
 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in long[] data)
 {
  enforce(H5LTmake_dataset_long(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!long error"));
 }
 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in float[] data)
 {
  enforce(H5LTmake_dataset_float(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!float error"));
 }
 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in double[] data)
 {
  enforce(H5LTmake_dataset_double(locID,datasetName.toStringz,cast(int)dims.length,dims.ptr,data.ptr)>=0,
   new Exception("H5Lite.make!double error"));
 }
 void make(hid_t locID,string datasetName, hsize_t[] dims, hid_t typeID, in string data)
 {
  enforce(H5LTmake_dataset_string(locID,datasetName.toStringz,data.ptr)>=0,
   new Exception("H5Lite.make!string error"));
 }







 herr_t H5LTread_dataset( hid_t loc_id, const (char*) dset_name, hid_t type_id, void *buffer );

 void read(hid_t loc_id, string datasetName,char* buf)
 {
  enforce(H5LT_read_dataset_char(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!char error"));
 }

 void read(hid_t loc_id, string datasetName, short* buf)
 {
  enforce(H5LT_read_dataset_short(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!short error"));
 }

 void read(hid_t loc_id, string datasetName, int* buf)
 {
  enforce(H5LT_read_dataset_int(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!int error"));
 }

 void read(hid_t loc_id, string datasetName, long* buf)
 {
  enforce(H5LT_read_dataset_long(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!long error"));
 }

 void read(hid_t loc_id, string datasetName, long* buf)
 {
  enforce(H5LT_read_dataset_long(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!long error"));
 }

 void read(hid_t loc_id, string datasetName, float* buf)
 {
  enforce(H5LT_read_dataset_float(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!float error"));
 }

 void read(hid_t loc_id, string datasetName, double* buf)
 {
  enforce(H5LT_read_dataset_double(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!double error"));
 }

 void read(hid_t loc_id, string datasetName, char* buf)
 {
  enforce(H5LT_read_dataset_string(loc_id,datasetName.toStringz,buf)>=0,new Exception("H5Lite.read!char error"));
 }







 int getDataSetNumDims(hid_t locID, string datasetName)
 {
  int ret;
  enforce(H5LTget_dataset_ndims(locID,datasetName.toStringz,&ret)>=0,new ExceptioN("H5Lite.getDataSetNumDims error"));
  return ret;
 }

 int getDataSetSize(hid_t locID, string datasetName)
 {
  hsize_t dims,
  H5T_class_t typeClass;
  size_t typeSize;
  enforce(H5LTget_dataset_info(locID,datasetName.toStringz,&dims,&typeClass,&typeSize );
  return typeSize;
 }

 H5T_class_t getDataSetClass(hid_t loc_id, string datasetName)
 {
  hsize_t dims,
  H5T_class_t typeClass;
  size_t typeSize;
  enforce(H5LTget_dataset_info(locID,datasetName.toStringz,&dims,&typeClass,&typeSize );
  return typeClass;
 }

 alias H5LiteInfo=Tuple!(dims,"dims",H5T_class_t,"typeClass",size_t,"typeSize");
 H5LiteInfo getDataSetInfo(hid_t loc_id, string datasetName)
 {
  hsize_t dims,
  H5T_class_t typeClass;
  size_t typeSize;
  enforce(H5LTget_dataset_info(locID,datasetName.toStringz,&dims,&typeClass,&typeSize );
  return H5LiteInfo(dims,typeClass,typeSize);
 }

 bool canFindDataset(hid_t locID, string datasetName)
 {
  return (H5LTfind_dataset(locID, datasetName.toStringz)==1);
 }







 void setAttribute(hid_t locID, string objectName, string attributeName, in char* data)
 {
  enforce(H5LTset_attribute_string(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.setAttribute!char error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in uchar* data)
 {
  enforce(H5LTset_attribute_uchar(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.setAttribute!uchar error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in short[] data)
 {
  enforce(H5LTset_attribute_short(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!short[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in ushort[] data)
 {
  enforce(H5LTset_attribute_ushort(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!ushort[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in int[] data)
 {
  enforce(H5LTset_attribute_int(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!int[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in uint[] data)
 {
  enforce(H5LTset_attribute_uint(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!uint[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in long[] data)
 {
  enforce(H5LTset_attribute_long(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!long[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in ulong[] data)
 {
  enforce(H5LTset_attribute_ulong(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!uint[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in float[] data)
 {
  enforce(H5LTset_attribute_float(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!float[] error"));
 }
 void setAttribute(hid_t locID, string objectName, string attributeName, in double[] data)
 {
  enforce(H5LTset_attribute_double(locID,objectName.toStringz,attributeName.toStringz,data.ptr,data.length)>=0,
   new Exception("H5Lite.setAttribute!double[] error"));
 }







 herr_t H5LTget_attribute( hid_t loc_id, const (char*) obj_name, const (char*) attr_name, hid_t mem_type_id, void *data );
 herr_t H5LTget_attribute_string( hid_t loc_id, const (char*) obj_name, const (char*) attr_name, char *data );

 void getAttribute(hid_t locID, string objectName, string attributeName, char* data)
 {
  enforce(H5LTget_attribute_char(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!char"));
 }

 void getAttribute(hid_t locID, string objectName, string attributeName, uchar* data)
 {
  enforce(H5LTget_attribute_uchar(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!uchar"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, short* data)
 {
  enforce(H5LTget_attribute_short(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!short"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, ushort* data)
 {
  enforce(H5LTget_attribute_ushort(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!ushort"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, int* data)
 {
  enforce(H5LTget_attribute_int(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!int"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, uint* data)
 {
  enforce(H5LTget_attribute_uint(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!uint"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, long* data)
 {
  enforce(H5LTget_attribute_long(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!long"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, ulong* data)
 {
  enforce(H5LTget_attribute_ulong(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!ulong"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, float* data)
 {
  enforce(H5LTget_attribute_float(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!float"));
 }
 void getAttribute(hid_t locID, string objectName, string attributeName, double* data)
 {
  enforce(H5LTget_attribute_double(locID,objectName.toStringz,attributeName.toStringz,data)>=0,
   new Exception("H5Lite.getAttribute!double"));
 }
 int getAttributeNumDims(hid_t locID, string objectName, string attributeName)
 {
  int numDims;
  enforce(H5LT_get_attribute_ndims(locID,objectName.toStringz, attributeName.toStringz,&numDims)>=0,
   new Exception("H5Lite.getAttributeNumDims error"));
  return numDims;
 }

 H5T_class_t getAttributeClassType(hid_t locID, string objectName, string attributeName)
 {
  int numDims;
  H5T_class_t classType;
  size_t typeSize;
  enforce(H5LT_get_attribute_info(locID,objectName.toStringz, attributeName.toStringz,&numDims,&classType,&typeSize)>=0,
   new Exception("H5Lite.getAttributeNumDims error"));
  return classType;
 }

 H5T_class_t getAttributeTypeSize(hid_t locID, string objectName, string attributeName)
 {
  int numDims;
  H5T_class_t classType;
  size_t typeSize;
  enforce(H5LT_get_attribute_info(locID,objectName.toStringz, attributeName.toStringz,&numDims,&classType,&typeSize)>=0,
   new Exception("H5Lite.getAttributeNumDims error"));
  return typeSize;
 }

 H5LiteInfo getAttributeInfo(hid_t locID, string objectName, string attributeName)
 {
  int numDims;
  H5T_class_t classType;
  size_t typeSize;
  enforce(H5LT_get_attribute_info(locID,objectName.toStringz, attributeName.toStringz,&numDims,&classType,&typeSize)>=0,
   new Exception("H5Lite.getAttributeNumDims error"));
  return H5LiteInfo(numDims,classType,typeSize);
 }
 hid_t H5LTtext_to_dtype(const (char*) text, H5LT_lang_t lang_type);
 herr_t H5LTdtype_to_text(hid_t dtype, char *str, H5LT_lang_t lang_type, size_t *len);







 bool canFindAttribute(hid_t locID,string name)
 {
  return (H5LTfind_attribute(locID,name.toStringz)==1);
 }

 bool isPathValid(hid_t locID, string path, bool checkObjectValid)
 {
  auto ret=H5LTpath_valid(locID,path.toStringz,checkObjectValid?1:0);
  enforce(ret>=0, new Exception("H5Lite.isPathValid error");
  return (ret!=0);
 }







 hid_t openFileImage(ubyte[] buf,bool readOnly,bool dontCopy)
 {
  auto ret=H5LTopen_file_image(buf.ptr,buf.length, (!readOnly?0x0001:0) |
               (!dontCopy?0x0002:0) |
               0x0004 );
  enforce(ret>=0, new Exception("H5Lite.openFileImage error");
  return ret;
 }
 hid_t H5PTcreate_fl ( hid_t loc_id, const (char*) dset_name, hid_t dtype_id, hsize_t chunk_size, int compression );
 static if (VLPT_REMOVED)
  hid_t H5PTcreate_vl ( hid_t loc_id, const (char*) dset_name, hsize_t chunk_size );

 hid_t H5PTopen( hid_t loc_id, const (char*) dset_name );
 herr_t H5PTclose( hid_t table_id );







herr_t H5PTappend( hid_t table_id, size_t nrecords, const (void*) data );







herr_t H5PTget_next( hid_t table_id, size_t nrecords, void * data );
herr_t H5PTread_packets( hid_t table_id, hsize_t start, size_t nrecords, void *data );
 herr_t H5PTget_num_packets( hid_t table_id, hsize_t *nrecords );
 herr_t H5PTis_valid( hid_t table_id );
 static if (VLPT_REMOVED)
  herr_t H5PTis_varlen( hid_t table_id );







 herr_t H5PTcreate_index( hid_t table_id );
 herr_t H5PTset_index( hid_t table_id, hsize_t pt_index );
 herr_t H5PTget_index( hid_t table_id, hsize_t *pt_index );







 static if (VLPT_REMOVED)
  herr_t H5PTfree_vlen_readbuff( hid_t table_id, size_t bufflen, void * buff );





struct H5Table
{

 string tableTitle;
 string datasetName;
 hid_t locID;
 string[] fieldNames;
 size_t[] fieldOffsets;
 hid_t[] fieldTypes;
 size_t[] fieldSizes;
 size_t typeSize;
 bool compress=false;





 this(string tableTitle,string datasetName,hid_t locID, string[] fieldNames, size_t[] fieldOffsets, hid_t[] fieldTypes, size_t typeSize,
    size_t[] fieldSizes,bool compress=false)
 {
  this.tableTitle=tableTitle;
  this.datasetName=datasetName;
  this.locID=locID;
  this.fieldNames=fieldNames;
  this.fieldOffsets=fieldOffsets;
  this.fieldTypes=fieldTypes;
  this.typeSize=typeSize;
  this.fieldSizes=fieldSizes
  this.compress=compress;
 }

 void makeTable(T)(hsize_t chunkSize, bool compress=false, T data)
 {
  ubyte[] fillData;
  fillData.length=this.typeSize;
  makeTable!T(chunkSize,fillData,compress,data);
 }

 void makeTable(T)(hsize_t chunkSize, ubyte[] fillData, bool compress=false, T data)
 {
  auto numFields=fieldNames.length;
  auto numRecords=data.length;
  enforce(numFields==fieldOffsets.length,new Exception("H5Table.makeTable: fieldNames must have same length as fieldOffsets");
  enforce(numFields==fieldTypes.length,new Exception("H5Table.makeTable: fieldNames must have same length as fieldTypes");

  enforce(H5TBmake_table(toStringz(tableTitle),locID,toStringz(datasetName),numFields,numRecords,typeSize,names.toCPointerArray,
   fieldOffsets.ptr,fieldTypes.ptr,chunkSize,fillData.ptr,compress?-1:0, buf.ptr)>=0,new Exception("H5Table.makeTable error"));
 }
 void appendRecords(T)(in T[] data)
 {
  auto numRecords=data.length;
  enforce(H5TBappend_records(locID,datasetName.toStringz, numRecords, typeSize, fieldOffsets.ptr,fieldSizes.ptr,data.ptr)>=0,
    new Exception("H5Table.appendRecords error"));
 }

 void writeRecords(T)(hsize_t start, in T[] data)
 {
  auto numRecords=data.length;
  enforce(H5TB_write_records(locID,datasetName.toStringz, start, numRecords,typeSize,fieldOffsets.ptr,fieldSizes.ptr,data.ptr)>=0,
    new Exception("H5Table.writeRecords error"));
 }


 void writeFieldsName(T)(hsize_t start, in T[] data)
 {
  auto numRecords=data.length
  enforce(H5TB_write_fields_name(locID,datasetName.ptr,fieldNames.toCPointerArray,start,numRecords,typeSize,fieldOffsets.ptr,
      fieldSizes.ptr,data.ptr)>=0, new Exception("H5Table.writeFieldsName error"));
 }

 void writeFieldsIndex(T)(in int[] fieldIndex, hsize_t start, in T[] data)
 {
  auto numRecords=data.length;
  enforce(H5TBwrite_fields_index(locID,datasetName.toStringz,numFields,fieldIndex.ptr,start,numRecords,typeSize,fieldOffsets.ptr,
       destSizes.ptr,data.ptr)>=0,new Exception("H5Table.writeFieldsIndex error"));
 }







 void readTable(T)(size_t destSize, in size_t[] destOffset, in size_t[] destSizes, ubyte[] buf)
 {
  enforce(H5TBread_table(locID,datasetName.toStringz,fieldSizes,fieldOffsets.ptr,fieldSizes.ptr,data.ptr)>=0,
    new Exception("H5Table.readTable error"));
 }

 void readFieldsName(T)(string[] fieldNames, hsize_t start, hsize_t numRecords,in T[] data)
 {
  auto numRecords=data.length;
  enforce(H5TBread_fields_name(locID,datasetName.toStringz,fieldNames.toCPointerArray,start,numRecords,typeSize,fieldOffsets.ptr,
    destSizes.ptr,buf.ptr)>=0,new Exception("H5Table.readFieldsName error"));
 }

 void readFieldsIndex(hid_t locID, string datasetName, hsize_t numFields)







 herr_t H5TBread_fields_index( hid_t loc_id, const (char*) dset_name, hsize_t nfields, const int *field_index, hsize_t start,
                        hsize_t nrecords, size_t type_size, const size_t *field_offset, const size_t *dst_sizes, void *buf );


 herr_t H5TBread_records( hid_t loc_id, const (char*) dset_name, hsize_t start, hsize_t nrecords, size_t type_size,
      const size_t *dst_offset, const size_t *dst_sizes, void *buf );
 herr_t H5TBget_table_info ( hid_t loc_id, const (char*) dset_name, hsize_t *nfields, hsize_t *nrecords );
 herr_t H5TBget_field_info( hid_t loc_id, const (char*) dset_name, char *field_names[], size_t *field_sizes, size_t *field_offsets,
      size_t *type_size );
 void deleteRecord(hsize_t start, hsize_t numRecords)
 {
  enforce(H5TB_delete_record(locID,datasetName.toStringz,start,numRecords)>=0,new Exception("H5Table.deleteRecord error"));
 }

 void insertRecord(T)(hsize_t start, T data)
 {
  enforce(H5TBinsert_record(locID,datasetName.toStringz, start,data.length, fieldSizes.ptr, fieldOffsets.ptr,fieldSizes.ptr,data.ptr)
   >=0, new Exception("H5Table.insertRecord error"));
 }

 void addRecordsFrom(hsize_t start1, hsize_t numRecords, hsize_t start2, H5Table dataset2)
 {
  enforce H5TB_add_records_from(locID,datasetName.toStringz,start1,numRecords,dataset2.datasetName,start2)>=0,
    new Exception("H5Table.addRecordsFrom error");
 }

 void combineTables(H5Table dataset2
 herr_t H5TBcombine_tables( hid_t loc_id1, const (char*) dset_name1, hid_t loc_id2, const (char*) dset_name2, const (char*) dset_name3 );
 herr_t H5TBinsert_field( hid_t loc_id, const (char*) dset_name, const (char*) field_name, hid_t field_type, hsize_t position,
                          const (void*) fill_data, const (void*) buf );
 herr_t H5TBdelete_field( hid_t loc_id, const (char*) dset_name, const (char*) field_name );
 string getTableTitle(hid_t locID)
 {
  string
 }
 herr_t H5TBAget_title( hid_t loc_id, char *table_title );
 htri_t H5TBAget_fill(hid_t loc_id, const (char*) dset_name, hid_t dset_id, ubyte *dst_buf);

+/
