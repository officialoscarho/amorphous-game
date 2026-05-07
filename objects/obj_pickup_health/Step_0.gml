if (global.paused) exit;
ysp += grv;
if (ysp > 6) ysp = 6;
y += ysp;

var _tilemap = layer_tilemap_get_id(LAYER_TILES);
if (_tilemap != -1 && ysp >= 0) {
    var _inside_floor = (
        tilemap_get_at_pixel(_tilemap, bbox_left, bbox_bottom) != 0 ||
        tilemap_get_at_pixel(_tilemap, bbox_right - 1, bbox_bottom) != 0
    );

    var _snap = 0;
    while (_inside_floor && _snap < 32) {
        y--;
        _snap++;
        _inside_floor = (
            tilemap_get_at_pixel(_tilemap, bbox_left, bbox_bottom) != 0 ||
            tilemap_get_at_pixel(_tilemap, bbox_right - 1, bbox_bottom) != 0
        );
    }

    if (_snap > 0) ysp = 0;
}

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    with (obj_player) player_gain_health(PICKUP_HEALTH_AMOUNT);
    instance_destroy();
}
