function player_step() {
    if (global.paused || global.scene_lock) {
        xsp = 0;
        player_animate();
        return;
    }

    if (invuln_frames > 0) invuln_frames--;
    if (attack_cooldown > 0) attack_cooldown--;
    if (attack_anim_timer > 0) attack_anim_timer--;
    if (dash_cooldown > 0) dash_cooldown--;

    switch (state) {
        case PSTATE.BLOB:    player_state_blob();    break;
        case PSTATE.NORMAL:  player_state_normal();  break;
        case PSTATE.DASHING: player_state_dashing(); break;
        case PSTATE.HURT:    player_state_hurt();    break;
        case PSTATE.DEAD:    player_state_dead();    break;
    }

    player_respawn_check();
    player_animate();
    player_camera_follow();
}

function player_state_blob() {
    player_input_move(PLAYER_BLOB_SPEED);
    player_input_jump();
    player_input_attack();
    player_apply_gravity();
    player_apply_collision();
}

function player_state_normal() {
    player_input_move(PLAYER_MOVE_SPEED);
    player_input_jump();
    player_input_attack();
    player_input_dash();
    player_apply_gravity();
    player_apply_collision();
}

function player_state_dashing() {
    xsp = dash_dir * PLAYER_DASH_SPEED;
    ysp = 0;
    player_apply_collision();

    dash_frames--;
    if (dash_frames <= 0) {
        state = PSTATE.NORMAL;
        dash_cooldown = PLAYER_DASH_COOLDOWN_FRAMES;
    }
}

function player_state_hurt() {
    player_apply_gravity();
    player_apply_collision();

    hurt_frames--;
    if (hurt_frames <= 0) {
        state = (hurt_return_state == PSTATE.BLOB && !global.save.prologue_shift_done) ? PSTATE.BLOB : PSTATE.NORMAL;
    }
}

function player_state_dead() {
    xsp = 0;
    player_apply_gravity();
    player_apply_collision();

    death_timer--;
    if (death_timer <= 0) player_do_respawn();
}

function player_input_move(_speed) {
    var _move = 0;
    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) _move = 1;
    if (keyboard_check(vk_left) || keyboard_check(ord("A"))) _move = -1;

    xsp = _move * _speed;
    if (_move != 0) facing = _move;
}

function player_input_jump() {
    if (keyboard_check_pressed(vk_space) && jumps_left > 0) {
        ysp = PLAYER_JUMP_FORCE;
        jumps_left--;
    }
}

function player_input_attack() {
    if ((mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("J"))) && attack_cooldown <= 0) {
        attack_cooldown = PLAYER_ATTACK_COOLDOWN;
        attack_anim_timer = 8;

        var _is_blob = (state == PSTATE.BLOB);
        var _atk_reach = _is_blob ? 54 : 64;
        var _atk_x = x + facing * _atk_reach;
        var _atk_y = _is_blob ? y - 30 : y - 64;
        var _atk = instance_create_layer(_atk_x, _atk_y, LAYER_INSTANCES, obj_attack_hitbox);
        _atk.direction_facing = facing;
        _atk.damage = PLAYER_ATTACK_DAMAGE;
        _atk.life_frames = 8;
    }
}

function player_input_dash() {
    if (!global.has_dash) return;
    if (dash_cooldown > 0) return;

    if (keyboard_check_pressed(vk_shift)) {
        state = PSTATE.DASHING;
        dash_dir = facing;
        dash_frames = PLAYER_DASH_FRAMES;
        invuln_frames = PLAYER_DASH_FRAMES + 4;
    }
}

function player_apply_gravity() {
    ysp += PLAYER_GRAVITY;
    if (ysp > PLAYER_FALL_CAP) ysp = PLAYER_FALL_CAP;
}

function player_apply_collision() {
    var _tilemap = layer_tilemap_get_id(LAYER_TILES);
    if (_tilemap == -1) {
        x += xsp;
        y += ysp;
        on_ground = false;
        return;
    }

    if (xsp != 0) {
        var _edge_x = (xsp > 0) ? bbox_right - x : bbox_left - x;
        var _probe_x = x + xsp + _edge_x;
        var _hit_top = tilemap_get_at_pixel(_tilemap, _probe_x, bbox_top);
        var _hit_bottom = tilemap_get_at_pixel(_tilemap, _probe_x, bbox_bottom - 1);

        if (_hit_top != 0 || _hit_bottom != 0) {
            while (
                tilemap_get_at_pixel(_tilemap, x + sign(xsp) + _edge_x, bbox_top) == 0 &&
                tilemap_get_at_pixel(_tilemap, x + sign(xsp) + _edge_x, bbox_bottom - 1) == 0
            ) {
                x += sign(xsp);
            }
            xsp = 0;
        }
        x += xsp;
    }

    on_ground = false;
    if (ysp != 0) {
        var _edge_y = (ysp > 0) ? bbox_bottom - y : bbox_top - y;
        var _probe_y = y + ysp + _edge_y;
        var _hit_left = tilemap_get_at_pixel(_tilemap, bbox_left, _probe_y);
        var _hit_right = tilemap_get_at_pixel(_tilemap, bbox_right - 1, _probe_y);

        if (_hit_left != 0 || _hit_right != 0) {
            while (
                tilemap_get_at_pixel(_tilemap, bbox_left, y + sign(ysp) + _edge_y) == 0 &&
                tilemap_get_at_pixel(_tilemap, bbox_right - 1, y + sign(ysp) + _edge_y) == 0
            ) {
                y += sign(ysp);
            }

            if (ysp > 0) {
                on_ground = true;
                jumps_left = global.has_double_jump ? 2 : 1;
                dash_cooldown = 0;
            }
            ysp = 0;
        }
        y += ysp;
    }
}

function player_camera_follow() {
    if (!variable_instance_exists(id, "cam") || cam == -1) return;
    var _cw = camera_get_view_width(cam);
    var _ch = camera_get_view_height(cam);
    var _cx = clamp(x - _cw * 0.5, 0, max(0, room_width - _cw));
    var _cy = clamp(y - _ch * 0.5, 0, max(0, room_height - _ch));
    camera_set_view_pos(cam, _cx, _cy);
}

function player_respawn_check() {
    if (y > room_height + 256) player_do_respawn();
}

function player_do_respawn() {
    game_continue();
}
