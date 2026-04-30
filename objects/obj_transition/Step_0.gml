if (global.paused) exit;

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    game_goto_room(target_room, target_x, target_y, target_state);
}