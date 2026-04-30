if (global.paused) exit;

sprite_index = pressed ? spr_switch_on : spr_switch_off;

if (!pressed && instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("E"))) {
        pressed = true;

        with (obj_door_locked) {
            if (door_id == other.door_id) is_open = true;
        }

        with (obj_laser_barrier) {
            if (barrier_id == other.door_id) active = false;
        }
    }
}