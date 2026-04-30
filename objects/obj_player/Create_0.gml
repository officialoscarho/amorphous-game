state = PSTATE.NORMAL;

xsp = 0;
ysp = 0;
facing = 1;
on_ground = false;
jumps_left = 1;

attack_cooldown = 0;
attack_anim_timer = 0;
invuln_frames = 0;
hurt_frames = 0;
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
    global.pending_spawn_active = false;
}

cam = camera_create();
camera_set_view_size(cam, 1366, 768);
view_set_camera(0, cam);
view_set_visible(0, true);
view_set_wport(0, 1366);
view_set_hport(0, 768);