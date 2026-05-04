if (global.paused) exit;

visible = active;
if (!active) exit;

if (tick > 0) tick--;
if (instance_exists(obj_player) && place_meeting(x, y, obj_player) && tick <= 0) {
    with (obj_player) player_take_damage(other.damage, other.x);
    tick = 30;
}