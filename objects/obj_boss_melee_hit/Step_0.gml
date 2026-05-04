if (global.paused) exit;

life_frames--;
if (life_frames <= 0) {
    instance_destroy();
    exit;
}

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    with (obj_player) player_take_damage(other.damage, other.x);
    instance_destroy();
}