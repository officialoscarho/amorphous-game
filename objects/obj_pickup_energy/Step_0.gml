// === obj_pickup_health :: Step ===
ysp += grv;
if (ysp > 6) ysp = 6;
y += ysp;

// Settle on tilemap
var tilemap = layer_tilemap_get_id(LAYER_TILES);
if (tilemap != -1 && tilemap_get_at_pixel(tilemap, x, y + 8) != 0) {
    ysp = 0;
}

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    with (obj_player) player_gain_energy(PICKUP_ENERGY_AMOUNT);
    instance_destroy();
}