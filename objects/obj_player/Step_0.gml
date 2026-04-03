// Loop calls all relevant player functions stored in scr_player

player_move();
player_jump();
player_gravity();
player_collision_x();
player_collision_y();
//player_attack(); // TODO: needs obj_attack_hitbox
player_respawn_check();

// Camera follow player, then clamp to room bounds
var cx = x - camera_get_view_width(cam) * 0.5;
var cy = y - camera_get_view_height(cam) * 0.5;
cx = clamp(cx, 0, room_width - camera_get_view_width(cam));
cy = clamp(cy, 0, room_height - camera_get_view_height(cam));
camera_set_view_pos(cam, cx, cy);