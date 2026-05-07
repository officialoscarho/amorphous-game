boss_id = "boss";
boss_name = "Boss";
hp_max = 500;
hp = hp_max;
phase = 1;
phase_max = 3;
attack_timer = 0;
phase_timer = 0;
state_timer = 0;
facing = -1;
sprite_face_sign = 1;
xsp = 0;
ysp = 0;
move_speed = 2;
contact_damage = 18;
hurt_flash_timer = 0;
dead = false;
arena_floor_y = y;
arena_floor_resolved = false;
boss_ai_action = function() {
    xsp = 0;
};
boss_phase_change_action = function() {
};
boss_defeat_action = function() {
};
global.boss = id;
