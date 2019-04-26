


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
    alias H5P_prp_close_func_t = int function();
    alias H5P_prp_compare_func_t = int function(const(void)*, const(void)*, c_long);
    alias H5P_prp_copy_func_t = int function();
    alias H5P_prp_delete_func_t = int function();
    alias H5P_prp_get_func_t = int function();
    alias H5P_prp_set_func_t = int function();
    alias H5P_prp_create_func_t = int function();
    alias H5P_prp_cb2_t = int function(int, const(char)*, c_long, void*);
    alias H5P_prp_cb1_t = int function(const(char)*, c_long, void*);
}


alias size_t = ulong;
