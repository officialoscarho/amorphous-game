if (global.paused) exit;
if (variable_global_exists("room_transition_active") && global.room_transition_active) exit;

if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    game_begin_room_transition(target_room, target_x, target_y, target_state);
}
