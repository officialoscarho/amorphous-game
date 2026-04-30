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
    global.boss = noone;

    global.pending_spawn_active = false;
    global.pending_spawn_x = 128;
    global.pending_spawn_y = 704;
    global.pending_player_state = PSTATE.NORMAL;
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
    global.gameplay_active = true;

    room_goto(_room);
    return true;
}

function game_start_new() {
    save_delete_current();
    save_write();
    game_runtime_apply_save();
    return game_goto_room("Prologue", 128, 704, PSTATE.BLOB);
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
    global.gameplay_active = false;
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