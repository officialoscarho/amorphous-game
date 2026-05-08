human_start_count = instance_number(obj_enemy_worker)
    + instance_number(obj_enemy_scientist)
    + instance_number(obj_enemy_security_guard)
    + instance_number(obj_enemy_soldier);
shift_done = global.save.prologue_shift_done;

if (instance_exists(obj_player)) {
    obj_player.state = shift_done ? PSTATE.NORMAL : PSTATE.BLOB;
    with (obj_player) {
        player_apply_form_mask();
        player_resolve_form_overlap();
    }
}
