// Initialize Movement Vars
xsp = 0;
ysp = 0;
gravity = 0.5;
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
collision_layer = layer_tilemap_get_id("Tiles_Collider");
layer_set_visible("Tiles_Collider", false);