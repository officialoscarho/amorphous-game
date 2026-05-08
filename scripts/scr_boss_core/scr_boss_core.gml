function boss_ai() {
    xsp = 0;
}

function boss_on_phase_change() {
}

function boss_on_defeat() {
}

function boss_take_damage(_amount) {
    if (dead) return;

    hp -= _amount;
    hurt_flash_timer = 6;
    if (hp <= 0) {
        hp = 0;
        dead = true;
        state_timer = 60;
        xsp = 0;
    }
}

function boss_floor_blocked_at(_tilemap, _candidate_y, _edge_y, _left_x, _right_x) {
    var _probe_y = _candidate_y + _edge_y;
    return (
        tilemap_get_at_pixel(_tilemap, x + _left_x, _probe_y) != 0 ||
        tilemap_get_at_pixel(_tilemap, x + _right_x, _probe_y) != 0
    );
}

function boss_find_floor_y() {
    var _tilemap = layer_tilemap_get_id(LAYER_TILES);
    if (_tilemap == -1) return y;

    var _edge_y = bbox_bottom - y;
    var _left_x = bbox_left - x;
    var _right_x = bbox_right - x - 1;
    var _floor_y = y;

    var _lift = 0;
    while (_lift < 128 && boss_floor_blocked_at(_tilemap, _floor_y, _edge_y, _left_x, _right_x)) {
        _floor_y--;
        _lift++;
    }

    var _max_drop = max(512, room_height);
    for (var _drop = 0; _drop < _max_drop; _drop++) {
        if (boss_floor_blocked_at(_tilemap, _floor_y + 1, _edge_y, _left_x, _right_x)) {
            return _floor_y;
        }
        _floor_y++;
    }

    return y;
}

function boss_apply_horizontal_collision() {
    var _tilemap = layer_tilemap_get_id(LAYER_TILES);
    if (_tilemap == -1) {
        x += xsp;
        return;
    }

    if (xsp == 0) return;

    var _edge_x = (xsp > 0) ? bbox_right - x : bbox_left - x;
    var _probe_x = x + xsp + _edge_x;
    var _probe_top = bbox_top + 4;
    var _probe_mid = (bbox_top + bbox_bottom) * 0.5;
    var _probe_bottom = bbox_bottom - 1;

    var _blocked = (
        tilemap_get_at_pixel(_tilemap, _probe_x, _probe_top) != 0 ||
        tilemap_get_at_pixel(_tilemap, _probe_x, _probe_mid) != 0 ||
        tilemap_get_at_pixel(_tilemap, _probe_x, _probe_bottom) != 0
    );

    if (_blocked) {
        while (
            tilemap_get_at_pixel(_tilemap, x + sign(xsp) + _edge_x, _probe_top) == 0 &&
            tilemap_get_at_pixel(_tilemap, x + sign(xsp) + _edge_x, _probe_mid) == 0 &&
            tilemap_get_at_pixel(_tilemap, x + sign(xsp) + _edge_x, _probe_bottom) == 0
        ) {
            x += sign(xsp);
        }
        xsp = 0;
    }

    x += xsp;
}
