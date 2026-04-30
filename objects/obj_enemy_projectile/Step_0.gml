if (global.paused) exit;

x += speed_x * direction_facing;
image_xscale = direction_facing;

life_frames--;
if (life_frames <= 0) {
    instance_destroy();
    exit;
}

if (place_meeting(x, y, obj_player)) {
    with (obj_player) player_take_damage(other.damage, other.x);
    instance_destroy();
    exit;
}

var _tilemap = layer_tilemap_get_id(LAYER_TILES);
if (_tilemap != -1 && tilemap_get_at_pixel(_tilemap, x, y) != 0) {
    instance_destroy();
}