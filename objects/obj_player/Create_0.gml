// Initialize Movement Vars
xsp = 0;
ysp = 0;
grv = 0.5;
move_spd = 4;
jump_force = -12;
jumps_max = 2;
jumps_left = 2;
on_ground = false;

// Initialize Combat Vars
attack_cooldown = 0;
attack_cooldown_max = 30;
facing = 1;

// Collision Tile Set
collision_layer = layer_tilemap_get_id("MainTiles");

//Functions
//Created in scr_player

// Camera
cam = camera_create();
camera_set_view_size(cam, 1920, 1080);
view_set_camera(0, cam);
view_set_visible(0, true);
view_set_wport(0, 1920);
view_set_hport(0, 1080);