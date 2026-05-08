function game_runtime_apply_save() {
    save_backfill();
    global.player_health_max = global.save.max_health;
    global.player_health = global.player_health_max;
    global.player_energy_max = global.save.max_energy;
    global.player_energy = 0;
    global.has_double_jump = global.save.has_double_jump;
    global.has_dash = global.save.has_dash;
    global.has_ultimate = global.save.has_ultimate;
    global.respawn_room = global.save.respawn_room;
    global.respawn_x = global.save.respawn_x;
    global.respawn_y = global.save.respawn_y;
}

function game_runtime_init() {
    save_read();
    save_backfill();
    game_runtime_apply_save();

    global.paused = false;
    global.gameplay_active = false;
    global.scene_lock = false;
    global.death_menu_active = false;
    global.boss = noone;

    global.pending_spawn_active = false;
    global.pending_spawn_x = 128;
    global.pending_spawn_y = 704;
    global.pending_player_state = PSTATE.NORMAL;

    global.room_transition_active = false;
    global.room_transition_phase = 0;
    global.room_transition_timer = 0;
    global.room_transition_alpha = 0;
    global.room_transition_target_room = "";
    global.room_transition_target_x = 128;
    global.room_transition_target_y = 704;
    global.room_transition_target_state = PSTATE.NORMAL;
}

function game_room_exists(_room_name) {
    return asset_get_index(_room_name) != -1;
}

function game_goto_room(_room_name, _x, _y, _state) {
    var _room = asset_get_index(_room_name);
    if (_room == -1) {
        show_debug_message("Missing room: " + string(_room_name));
        return false;
    }

    global.pending_spawn_active = true;
    global.pending_spawn_x = _x;
    global.pending_spawn_y = _y;
    global.pending_player_state = _state;
    global.paused = false;
    global.scene_lock = false;
    global.death_menu_active = false;
    global.gameplay_active = true;

    room_goto(_room);
    return true;
}

function game_begin_room_transition(_room_name, _x, _y, _state) {
    if (global.room_transition_active) return false;
    if (!game_room_exists(_room_name)) {
        show_debug_message("Missing room: " + string(_room_name));
        return false;
    }

    global.room_transition_active = true;
    global.room_transition_phase = 0;
    global.room_transition_timer = 0;
    global.room_transition_alpha = 0;
    global.room_transition_target_room = _room_name;
    global.room_transition_target_x = _x;
    global.room_transition_target_y = _y;
    global.room_transition_target_state = _state;
    global.scene_lock = true;
    global.paused = false;
    global.death_menu_active = false;
    return true;
}

function game_update_room_transition() {
    if (!global.room_transition_active) return;

    var _fade_frames = max(1, ROOM_TRANSITION_FADE_FRAMES);

    if (global.room_transition_phase == 0) {
        global.room_transition_timer++;
        global.room_transition_alpha = min(1, global.room_transition_timer / _fade_frames);

        if (global.room_transition_timer >= _fade_frames) {
            global.room_transition_phase = 1;
            global.room_transition_timer = _fade_frames;
            global.room_transition_alpha = 1;
            game_goto_room(
                global.room_transition_target_room,
                global.room_transition_target_x,
                global.room_transition_target_y,
                global.room_transition_target_state
            );
            global.scene_lock = true;
        }
        return;
    }

    global.room_transition_timer--;
    global.room_transition_alpha = max(0, global.room_transition_timer / _fade_frames);

    if (global.room_transition_timer <= 0) {
        global.room_transition_active = false;
        global.room_transition_alpha = 0;
        global.scene_lock = false;
    }
}

function game_find_first_asset(_names) {
    for (var _i = 0; _i < array_length(_names); _i++) {
        var _asset = asset_get_index(_names[_i]);
        if (_asset != -1) return _asset;
    }
    return -1;
}

function game_apply_room_background() {
    var _room_name = room_get_name(room);
    var _bg_sprite = -1;

    if (string_pos("rm_l1_", _room_name) == 1) {
        _bg_sprite = game_find_first_asset([
            "spr_bg_level1",
            "spr_background_level1",
            "spr_l1_background",
            "spr_background_l1",
            "spr_level1_background"
        ]);
    } else if (string_pos("rm_l2_", _room_name) == 1) {
        _bg_sprite = game_find_first_asset([
            "spr_bg_level2",
            "spr_background_level2",
            "spr_l2_background",
            "spr_background_l2",
            "spr_level2_background"
        ]);
    }

    if (_bg_sprite == -1) return false;

    var _bg_layer = layer_get_id(LAYER_BG);
    if (_bg_layer == -1) return false;

    var _bg_id = layer_background_get_id(_bg_layer);
    if (_bg_id == -1) return false;

    layer_background_sprite(_bg_id, _bg_sprite);
    layer_background_htiled(_bg_id, true);
    layer_background_vtiled(_bg_id, false);
    layer_background_stretch(_bg_id, false);
    layer_background_xscale(_bg_id, 1);
    layer_background_yscale(_bg_id, 1);
    return true;
}

function game_start_new() {
    save_delete_current();
    save_write();
    game_runtime_apply_save();
    return game_goto_room("Prologue", 128, 704, PSTATE.BLOB);
}

function game_delete_save() {
    var _had_file = save_has_file();
    save_delete_current();
    game_runtime_apply_save();
    return _had_file;
}

function game_continue() {
    if (!save_has_file()) return false;

    save_read();
    save_backfill();
    game_runtime_apply_save();

    var _state = global.save.prologue_shift_done ? PSTATE.NORMAL : PSTATE.BLOB;
    return game_goto_room(global.save.respawn_room, global.save.respawn_x, global.save.respawn_y, _state);
}

function game_return_to_title() {
    global.paused = false;
    global.scene_lock = false;
    global.death_menu_active = false;
    global.gameplay_active = false;
    global.room_transition_active = false;
    global.room_transition_alpha = 0;
    view_enabled = false;
    room_goto(rm_title);
}

function game_register_checkpoint(_x, _y) {
    global.respawn_room = room_get_name(room);
    global.respawn_x = _x;
    global.respawn_y = _y;

    global.save.respawn_room = global.respawn_room;
    global.save.respawn_x = global.respawn_x;
    global.save.respawn_y = global.respawn_y;
    save_write();
}
