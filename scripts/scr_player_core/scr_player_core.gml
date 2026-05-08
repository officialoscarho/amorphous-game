function player_step() {
    if (global.paused || global.scene_lock) {
        xsp = 0;
        player_animate();
        return;
    }

    if (invuln_frames > 0) invuln_frames--;
    if (attack_cooldown > 0) attack_cooldown--;
    if (attack_anim_timer > 0) attack_anim_timer--;
    if (shoot_cooldown > 0) shoot_cooldown--;
    if (shoot_anim_timer > 0) shoot_anim_timer--;
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
    ducking = false;
    player_input_move(PLAYER_BLOB_SPEED);
    player_input_jump();
    player_input_attack();
    player_apply_gravity();
    player_apply_collision();
}

function player_state_normal() {
    player_input_duck();
    player_input_move(ducking ? PLAYER_DUCK_SPEED : PLAYER_MOVE_SPEED);
    if (!ducking) player_input_jump();
    player_input_attack();
    player_input_shoot();
    if (!ducking) player_input_dash();
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

    if (death_timer > 0) {
        death_timer--;
        return;
    }

    ysp = 0;
    global.death_menu_active = true;
    global.scene_lock = true;
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
        var _max_jumps = global.has_double_jump ? 2 : 1;
        var _is_extra_jump = !on_ground && jumps_left < _max_jumps;
        ysp = _is_extra_jump ? PLAYER_DOUBLE_JUMP_FORCE : PLAYER_JUMP_FORCE;
        jumps_left--;
    }
}

function player_input_duck() {
    if (!variable_instance_exists(id, "ducking")) ducking = false;

    var _wants_duck = keyboard_check(vk_down) || keyboard_check(ord("S"));
    if (state != PSTATE.NORMAL || !on_ground) {
        if (ducking && player_can_stand()) ducking = false;
        return;
    }

    if (_wants_duck) {
        ducking = true;
        return;
    }

    if (ducking && player_can_stand()) ducking = false;
}

function player_input_attack() {
    if ((mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("J"))) && attack_cooldown <= 0) {
        var _is_blob = (state == PSTATE.BLOB);

        attack_cooldown = PLAYER_ATTACK_COOLDOWN;
        attack_anim_timer = _is_blob ? PLAYER_BLOB_ATTACK_ANIM_FRAMES : PLAYER_HUMANOID_ATTACK_ANIM_FRAMES;
        image_index = 0;

        var _atk_reach = _is_blob ? 66 : 84;
        var _atk_x = x + facing * _atk_reach;
        var _atk_y = _is_blob ? y - 30 : y - 64;
        var _atk = instance_create_layer(_atk_x, _atk_y, LAYER_INSTANCES, obj_attack_hitbox);
        _atk.direction_facing = facing;
        _atk.damage = PLAYER_ATTACK_DAMAGE;
        _atk.life_frames = 10;

        if (_is_blob) {
            _atk.visible = false;
            _atk.hit_half_width = 44;
            _atk.hit_top = -28;
            _atk.hit_bottom = 24;
        } else {
            _atk.visual_scale = 0.8;
            _atk.hit_half_width = 52;
            _atk.hit_top = -48;
            _atk.hit_bottom = 38;
        }
    }
}

function player_input_shoot() {
    if (shoot_cooldown > 0) return;
    if (!(mouse_check_button_pressed(mb_right) || keyboard_check_pressed(ord("K")))) return;

    shoot_cooldown = PLAYER_SHOOT_COOLDOWN;
    shoot_anim_timer = 8;

    var _shot_y = ducking ? y - 36 : y - 66;
    var _shot = instance_create_layer(x + facing * 42, _shot_y, LAYER_INSTANCES, obj_enemy_projectile);
    _shot.is_player_projectile = true;
    _shot.direction_facing = facing;
    _shot.speed_x = PLAYER_SHOT_SPEED;
    _shot.damage = PLAYER_SHOT_DAMAGE;
    _shot.life_frames = PLAYER_SHOT_LIFE_FRAMES;
    _shot.visual_scale = PLAYER_PROJECTILE_VISUAL_SCALE;
    _shot.image_blend = make_color_rgb(150, 225, 255);
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

function player_overlaps_solid_tiles() {
    var _tilemap = layer_tilemap_get_id(LAYER_TILES);
    if (_tilemap == -1) return false;

    var _left = bbox_left + 1;
    var _right = bbox_right - 1;
    var _top = bbox_top + 1;
    var _bottom = bbox_bottom - 1;

    return (
        tilemap_get_at_pixel(_tilemap, _left, _top) != 0 ||
        tilemap_get_at_pixel(_tilemap, _right, _top) != 0 ||
        tilemap_get_at_pixel(_tilemap, _left, _bottom) != 0 ||
        tilemap_get_at_pixel(_tilemap, _right, _bottom) != 0
    );
}

function player_resolve_form_overlap() {
    if (!player_overlaps_solid_tiles()) return;

    var _start_y = y;
    var _steps = 0;

    while (player_overlaps_solid_tiles() && _steps < 96) {
        y -= 1;
        _steps++;
    }
    if (!player_overlaps_solid_tiles()) {
        ysp = 0;
        return;
    }

    y = _start_y;
    _steps = 0;
    while (player_overlaps_solid_tiles() && _steps < 96) {
        y += 1;
        _steps++;
    }
    if (player_overlaps_solid_tiles()) y = _start_y;
    ysp = 0;
}

function player_can_stand() {
    var _old_mask = mask_index;
    var _old_ducking = ducking;

    ducking = false;
    player_apply_form_mask();
    var _blocked = player_overlaps_solid_tiles();

    ducking = _old_ducking;
    mask_index = _old_mask;
    return !_blocked;
}

function player_camera_follow() {
    if (!variable_instance_exists(id, "cam") || cam == -1) return;
    var _cw = camera_get_view_width(cam);
    var _ch = camera_get_view_height(cam);
    var _target_x = clamp(
        x + facing * CAMERA_LOOKAHEAD_X - _cw * 0.5,
        0,
        max(0, room_width - _cw)
    );
    var _target_y = clamp(y - _ch * 0.56, 0, max(0, room_height - _ch));
    var _cx = camera_get_view_x(cam);
    var _cy = camera_get_view_y(cam);

    if (abs(_target_x - _cx) < 1) {
        _cx = _target_x;
    } else {
        _cx = lerp(_cx, _target_x, CAMERA_FOLLOW_LERP);
    }

    if (abs(_target_y - _cy) < 1) {
        _cy = _target_y;
    } else {
        _cy = lerp(_cy, _target_y, CAMERA_FOLLOW_LERP);
    }
    camera_set_view_pos(cam, _cx, _cy);
}

function player_camera_snap() {
    if (!variable_instance_exists(id, "cam") || cam == -1) return;
    var _cw = camera_get_view_width(cam);
    var _ch = camera_get_view_height(cam);
    var _cx = clamp(
        x + facing * CAMERA_LOOKAHEAD_X - _cw * 0.5,
        0,
        max(0, room_width - _cw)
    );
    var _cy = clamp(y - _ch * 0.56, 0, max(0, room_height - _ch));
    camera_set_view_pos(cam, _cx, _cy);
}

function player_respawn_check() {
    if (y <= room_height + 256) return;
    if (state == PSTATE.DEAD) return;

    global.player_health = 0;
    state = PSTATE.DEAD;
    death_timer = 30;
    xsp = 0;
    ysp = 0;
}

function player_do_respawn() {
    global.death_menu_active = false;
    global.scene_lock = false;
    global.paused = false;
    game_continue();
}
