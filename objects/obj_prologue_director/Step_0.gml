if (global.paused || shift_done) exit;

var _human_count = instance_number(obj_enemy_worker)
    + instance_number(obj_enemy_scientist)
    + instance_number(obj_enemy_security_guard)
    + instance_number(obj_enemy_soldier);

if (_human_count < human_start_count) {
    shift_done = true;
    global.save.prologue_shift_done = true;
    save_write();

    if (instance_exists(obj_player)) {
        obj_player.state = PSTATE.NORMAL;
        obj_player.attack_anim_timer = 0;
        obj_player.xsp = 0;
        obj_player.ysp = 0;
        with (obj_player) {
            player_apply_form_mask();
            player_resolve_form_overlap();
        }
    }

    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("The shape holds.");
}
