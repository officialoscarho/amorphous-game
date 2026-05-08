state = PSTATE.NORMAL;

xsp = 0;
ysp = 0;
facing = 1;
on_ground = false;
jumps_left = 1;

attack_cooldown = 0;
attack_anim_timer = 0;
shoot_cooldown = 0;
shoot_anim_timer = 0;
ducking = false;
invuln_frames = 0;
hurt_frames = 0;
hurt_return_state = PSTATE.NORMAL;
death_timer = 0;

dash_frames = 0;
dash_cooldown = 0;
dash_dir = 1;

mask_index = spr_mask_player;
sprite_index = spr_player_humanoid_idle;

if (global.pending_spawn_active) {
    x = global.pending_spawn_x;
    y = global.pending_spawn_y;
    state = global.pending_player_state;
    hurt_return_state = (state == PSTATE.BLOB) ? PSTATE.BLOB : PSTATE.NORMAL;
    global.pending_spawn_active = false;
}

player_apply_form_mask();
player_resolve_form_overlap();
game_apply_room_background();

cam = camera_create();
camera_set_view_size(cam, CAMERA_VIEW_W, CAMERA_VIEW_H);
view_enabled = true;
view_set_camera(0, cam);
view_set_visible(0, true);
view_set_xport(0, 0);
view_set_yport(0, 0);
view_set_wport(0, CAMERA_VIEW_W);
view_set_hport(0, CAMERA_VIEW_H);
display_set_gui_size(CAMERA_VIEW_W, CAMERA_VIEW_H);
player_camera_snap();
