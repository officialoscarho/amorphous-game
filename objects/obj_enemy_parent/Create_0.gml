hp_max = 30;
hp = hp_max;
contact_damage = 10;
move_speed = 1.5;
detect_range = 220;
attack_range = 36;
attack_cooldown_max = 60;

state = ESTATE.IDLE;
state_timer = 0;
attack_timer = 0;
hurt_timer = 0;

xsp = 0;
ysp = 0;
grv = 0.5;
on_ground = false;
facing = -1;

hurt_flash_timer = 0;
drop_table = "default";