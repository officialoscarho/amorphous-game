// === obj_boss_security :: Create ===
event_inherited();

boss_name = "Head of Security";
hp_max = 400;
hp = hp_max;
contact_damage = 18;
move_speed = 2.0;

mask_index = spr_mask_boss_security;
sprite_index = spr_boss_security_idle;

// Phase 1 = pistol  (slow, accurate)
// Phase 2 = rifle   (3-burst, faster)
// Phase 3 = shotgun (spread of 3, close range)

// Attack pattern variables
shots_left_in_burst = 0;
burst_cooldown = 0;

boss_ai = function() {
    if (!instance_exists(obj_player)) return;

    var dx = obj_player.x - x;
    facing = (dx >= 0) ? 1 : -1;

    // Maintain spacing based on phase
    var ideal_distance = 280;
    if (phase == 2) ideal_distance = 200;
    if (phase == 3) ideal_distance = 140;

    if (abs(dx) > ideal_distance + 30) {
        xsp = facing * move_speed;
    } else if (abs(dx) < ideal_distance - 30) {
        xsp = -facing * move_speed;
    } else {
        xsp = 0;
    }

    // Attack cadence
    if (attack_timer <= 0 && shots_left_in_burst <= 0) {
        if (phase == 1) {
            boss_security_pistol();
            attack_timer = 80;
        } else if (phase == 2) {
            shots_left_in_burst = 3;
            burst_cooldown = 0;
        } else {
            boss_security_shotgun();
            attack_timer = 70;
        }
    }

    // Burst handling for rifle
    if (shots_left_in_burst > 0 && burst_cooldown <= 0) {
        boss_security_rifle();
        shots_left_in_burst--;
        burst_cooldown = 8;
        if (shots_left_in_burst <= 0) attack_timer = 50;
    }
    if (burst_cooldown > 0) burst_cooldown--;
};

boss_on_phase_change = function() {
    // Brief pause at phase change for readability
    attack_timer = 60;
    shots_left_in_burst = 0;
};

boss_on_defeat = function() {
    // Reward: double jump unlock
    global.has_double_jump = true;
    global.save.has_double_jump = true;
    save_write();

    if (instance_exists(obj_hud)) {
        with (obj_hud) hud_show_prompt("Ability gained: Double Jump");
    }
};

function boss_security_pistol() {
    var p = instance_create_layer(x + facing * 28, y - 28, LAYER_INSTANCES, obj_enemy_projectile);
    p.direction_facing = facing;
    p.speed_x = 9;
    p.damage = 18;
}

function boss_security_rifle() {
    var p = instance_create_layer(x + facing * 28, y - 28, LAYER_INSTANCES, obj_enemy_projectile);
    p.direction_facing = facing;
    p.speed_x = 11;
    p.damage = 12;
}

function boss_security_shotgun() {
    for (var i = -1; i <= 1; i++) {
        var p = instance_create_layer(x + facing * 28, y - 28 + i * 12, LAYER_INSTANCES, obj_enemy_projectile);
        p.direction_facing = facing;
        p.speed_x = 8;
        p.damage = 14;
    }
}