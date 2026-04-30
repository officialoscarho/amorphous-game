game_runtime_init();

if (!instance_exists(obj_hud)) {
    instance_create_layer(0, 0, LAYER_INSTANCES, obj_hud);
}

if (!instance_exists(obj_pause_menu)) {
    instance_create_layer(0, 0, LAYER_INSTANCES, obj_pause_menu);
}

room_goto(rm_title);