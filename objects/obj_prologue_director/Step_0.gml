if (global.paused || shift_done) exit;

if (instance_number(obj_enemy_worker) < worker_start_count) {
    shift_done = true;
    global.save.prologue_shift_done = true;
    save_write();

    if (instance_exists(obj_player)) {
        obj_player.state = PSTATE.NORMAL;
        obj_player.attack_anim_timer = 0;
    }

    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("The shape holds.");
}