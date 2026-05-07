event_inherited();
hp_max = 50;
hp = hp_max;
contact_damage = 12;
move_speed = 1.0;
detect_range = 420;
attack_range = 360;
attack_cooldown_max = 75;
attack_fire_frame = 12;
state = ESTATE.PATROL;
state_timer = 90;
mask_index = spr_mask_enemy_guard;
sprite_index = spr_enemy_guard_idle;

enemy_attack_action = function() {
    var _p = instance_create_layer(x + facing * 36, y - 68, LAYER_INSTANCES, obj_enemy_projectile);
    _p.direction_facing = facing;
    _p.speed_x = 7;
    _p.damage = 12;
    _p.life_frames = 90;
};
