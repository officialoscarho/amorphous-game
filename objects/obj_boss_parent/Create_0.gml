// === obj_boss_parent :: Create ===

boss_name = "Boss";
hp_max = 500;
hp = hp_max;

phase = 1;
phase_max = 3;
phase_timer = 0;
attack_timer = 0;
state_timer = 0;

facing = -1;
xsp = 0;
ysp = 0;
grv = 0.5;
on_ground = false;
move_speed = 2;

contact_damage = 18;
hurt_flash_timer = 0;

dead = false;

// Register self as the active boss for HUD use
global.boss = id;