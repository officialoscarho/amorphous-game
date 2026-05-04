worker_start_count = instance_number(obj_enemy_worker);
shift_done = global.save.prologue_shift_done;

if (instance_exists(obj_player)) {
    obj_player.state = shift_done ? PSTATE.NORMAL : PSTATE.BLOB;
}