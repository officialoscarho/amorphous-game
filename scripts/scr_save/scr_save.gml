function save_init_defaults() {
    global.save = {
        version: 2,
        respawn_room: "Prologue",
        respawn_x: 128,
        respawn_y: 704,
        max_health: 100,
        max_energy: 100,
        has_double_jump: false,
        has_dash: false,
        has_ultimate: false,
        prologue_shift_done: false,
        fragments_collected: [],
        bosses_defeated: []
    };
}

function save_backfill() {
    if (!variable_global_exists("save")) save_init_defaults();
    if (!variable_struct_exists(global.save, "version")) global.save.version = 2;
    if (!variable_struct_exists(global.save, "respawn_room")) global.save.respawn_room = "Prologue";
    if (!variable_struct_exists(global.save, "respawn_x")) global.save.respawn_x = 128;
    if (!variable_struct_exists(global.save, "respawn_y")) global.save.respawn_y = 704;
    if (!variable_struct_exists(global.save, "max_health")) global.save.max_health = 100;
    if (!variable_struct_exists(global.save, "max_energy")) global.save.max_energy = 100;
    if (!variable_struct_exists(global.save, "has_double_jump")) global.save.has_double_jump = false;
    if (!variable_struct_exists(global.save, "has_dash")) global.save.has_dash = false;
    if (!variable_struct_exists(global.save, "has_ultimate")) global.save.has_ultimate = false;
    if (!variable_struct_exists(global.save, "prologue_shift_done")) global.save.prologue_shift_done = false;
    if (!variable_struct_exists(global.save, "fragments_collected")) global.save.fragments_collected = [];
    if (!variable_struct_exists(global.save, "bosses_defeated")) global.save.bosses_defeated = [];
}

function save_write() {
    save_backfill();
    var _f = file_text_open_write(SAVE_FILE);
    file_text_write_string(_f, json_stringify(global.save));
    file_text_close(_f);
}

function save_read() {
    if (!file_exists(SAVE_FILE)) {
        save_init_defaults();
        return;
    }

    var _f = file_text_open_read(SAVE_FILE);
    var _raw = "";
    while (!file_text_eof(_f)) {
        _raw += file_text_read_string(_f);
        file_text_readln(_f);
    }
    file_text_close(_f);

    try {
        global.save = json_parse(_raw);
        save_backfill();
    } catch (_err) {
        save_init_defaults();
    }
}

function save_delete_current() {
    if (file_exists(SAVE_FILE)) file_delete(SAVE_FILE);
    save_init_defaults();
}

function save_has_file() {
    return file_exists(SAVE_FILE);
}

function save_array_has(_arr, _id) {
    for (var _i = 0; _i < array_length(_arr); _i++) {
        if (_arr[_i] == _id) return true;
    }
    return false;
}

function save_has_fragment(_id) {
    save_backfill();
    return save_array_has(global.save.fragments_collected, _id);
}

function save_add_fragment(_id) {
    save_backfill();
    if (!save_has_fragment(_id)) {
        array_push(global.save.fragments_collected, _id);
        save_write();
    }
}

function save_has_boss(_id) {
    save_backfill();
    return save_array_has(global.save.bosses_defeated, _id);
}

function save_add_boss(_id) {
    save_backfill();
    if (!save_has_boss(_id)) {
        array_push(global.save.bosses_defeated, _id);
        save_write();
    }
}