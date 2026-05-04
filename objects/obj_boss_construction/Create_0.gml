event_inherited();
boss_id = "katya";
boss_name = "Katya Snezhevna";
hp_max = 500;
hp = hp_max;
contact_damage = 22;
move_speed = 2.4;
attack_vis_timer = 0;
melee_telegraph_timer = 0;
throw_cooldown = 100;
mask_index = spr_mask_boss_construction;
sprite_index = spr_boss_construction_idle;

boss_ai = function() {
    if (!instance_exists(obj_player)) return;

    var _dx = obj_player.x - x;
    facing = (_dx >= 0) ? 1 : -1;

    if (abs(_dx) > 96) xsp = facing * move_speed * (phase == 3 ? 1.3 : 1);
    else xsp = 0;

    if (abs(_dx) <= 112 && attack_timer <= 0) {
        melee_telegraph_timer = 18;
        attack_timer = 70;
        attack_vis_timer = 24;
    }

    if (melee_telegraph_timer > 0) {
        melee_telegraph_timer--;
        if (melee_telegraph_timer == 1) {
            var _hit = instance_create_layer(x + facing * 58, y - 64, LAYER_INSTANCES, obj_boss_melee_hit);
            _hit.direction_facing = facing;
            _hit.damage = 25;
            _hit.life_frames = 10;
        }
    }

    if (phase >= 2) {
        throw_cooldown--;
        if (throw_cooldown <= 0) {
            var _obj = instance_create_layer(x + facing * 42, y - 96, LAYER_INSTANCES, obj_thrown_object);
            _obj.direction_facing = facing;
            _obj.damage = 20;
            throw_cooldown = (phase == 3) ? 75 : 115;
        }
    }
};

boss_on_phase_change = function() {
    attack_timer = 45;
    melee_telegraph_timer = 0;
    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("Katya recalibrates the mech.");
};

boss_on_defeat = function() {
    global.has_dash = true;
    global.save.has_dash = true;
    save_write();
    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("Ability gained: Air Dash");
};