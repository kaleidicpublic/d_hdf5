/* Define property list callback function pointer types */
typedef int (*H5P_prp_cb1_t)(const char *name, long size, void *value);
typedef int (*H5P_prp_cb2_t)(int prop_id, const char *name, long size, void *value);
typedef H5P_prp_cb1_t H5P_prp_create_func_t;
typedef H5P_prp_cb2_t H5P_prp_set_func_t;
typedef H5P_prp_cb2_t H5P_prp_get_func_t;
typedef H5P_prp_cb2_t H5P_prp_delete_func_t;
typedef H5P_prp_cb1_t H5P_prp_copy_func_t;
typedef int (*H5P_prp_compare_func_t)(const void *value1, const void *value2, long size);
typedef H5P_prp_cb1_t H5P_prp_close_func_t;

