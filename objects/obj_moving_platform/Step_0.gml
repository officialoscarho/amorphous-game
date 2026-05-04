if (global.paused) exit;

var _prev_x = x;
var _prev_y = y;

if (move_dir == "h") {
    x += dir_sign * move_speed;
    if (abs(x - start_x) >= move_range) dir_sign = -dir_sign;
} else {
    y += dir_sign * move_speed;
    if (abs(y - start_y) >= move_range) dir_sign = -dir_sign;
}

var _dx = x - _prev_x;
var _dy = y - _prev_y;

if (instance_exists(obj_player)) {
    var _p = instance_find(obj_player, 0);
    var _standing = _p.bbox_bottom <= bbox_top + 8 && _p.bbox_bottom >= bbox_top - 12;
    var _overlap = _p.bbox_right > bbox_left && _p.bbox_left < bbox_right;

    if (_standing && _overlap && _p.ysp >= 0) {
        _p.x += _dx;
        _p.y += _dy;
        _p.ysp = 0;
        _p.on_ground = true;
        _p.jumps_left = global.has_double_jump ? 2 : 1;
        _p.dash_cooldown = 0;
    }
}