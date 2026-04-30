if (global.paused) exit;
ysp += grv;
if (ysp > 6) ysp = 6;
y += ysp;

var _tilemap = layer_tilemap_get_id(LAYER_TILES);
if (_tilemap != -1 && tilemap_get_at_pixel(_tilemap, x, y + 8) != 0) ysp = 0;

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    with (obj_player) player_gain_health(PICKUP_HEALTH_AMOUNT);
    instance_destroy();
}