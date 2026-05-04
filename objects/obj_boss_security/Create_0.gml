event_inherited();
boss_id = "head_of_security";
boss_name = "Head of Security";
hp_max = 400;
hp = hp_max;
contact_damage = 18;
move_speed = 2;
attack_vis_timer = 0;
shots_left = 0;
burst_cooldown = 0;
mask_index = spr_mask_boss_security;
sprite_index = spr_boss_security_idle;

boss_ai = function() {
    if (!instance_exists(obj_player)) return;

    var _dx = obj_player.x - x;
    facing = (_dx >= 0) ? 1 : -1;

    var _ideal = 280;
    if (phase == 2) _ideal = 220;
    if (phase == 3) _ideal = 160;

    if (abs(_dx) > _ideal + 32) xsp = facing * move_speed;
    else if (abs(_dx) < _ideal - 32) xsp = -facing * move_speed;
    else xsp = 0;

    if (attack_timer <= 0 && shots_left <= 0) {
        if (phase == 1) {
            boss_security_shot(9, 18, 0);
            attack_timer = 80;
        } else if (phase == 2) {
            shots_left = 3;
            burst_cooldown = 0;
        } else {
            boss_security_shot(8, 14, -14);
            boss_security_shot(8, 14, 0);
            boss_security_shot(8, 14, 14);
            attack_timer = 70;
        }
    }

    if (shots_left > 0 && burst_cooldown <= 0) {
        boss_security_shot(11, 12, 0);
        shots_left--;
        burst_cooldown = 8;
        if (shots_left <= 0) attack_timer = 50;
    }

    if (burst_cooldown > 0) burst_cooldown--;
};

boss_on_phase_change = function() {
    attack_timer = 45;
    shots_left = 0;
};

boss_on_defeat = function() {
    global.has_double_jump = true;
    global.save.has_double_jump = true;
    save_write();
    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("Ability gained: Double Jump");
};

function boss_security_shot(_speed, _damage, _yoff) {
    attack_vis_timer = 12;
    var _p = instance_create_layer(x + facing * 28, y - 72 + _yoff, LAYER_INSTANCES, obj_enemy_projectile);
    _p.direction_facing = facing;
    _p.speed_x = _speed;
    _p.damage = _damage;
}