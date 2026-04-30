if (variable_instance_exists(id, "hit_ids")) {
    if (ds_exists(hit_ids, ds_type_list)) ds_list_destroy(hit_ids);
}