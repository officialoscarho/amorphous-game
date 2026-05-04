if (global.paused) exit;

ysp += grv;
x += xsp;
y += ysp;

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    with (obj_player) player_take_damage(other.damage, other.x);
    instance_destroy();
    exit;
}

var _tilemap = layer_tilemap_get_id(LAYER_TILES);
if (_tilemap != -1 && tilemap_get_at_pixel(_tilemap, x, y) != 0) {
    instance_destroy();
}

if (y > room_height + 256) instance_destroy();