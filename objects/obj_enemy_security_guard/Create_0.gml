event_inherited();
hp_max = 50;
hp = hp_max;
contact_damage = 12;
move_speed = 1.0;
detect_range = 340;
attack_range = 280;
attack_cooldown_max = 75;
state = ESTATE.PATROL;
state_timer = 90;
mask_index = spr_mask_enemy_guard;
sprite_index = spr_enemy_guard_idle;

enemy_perform_attack = function() {
    var _p = instance_create_layer(x + facing * 24, y - 64, LAYER_INSTANCES, obj_enemy_projectile);
    _p.direction_facing = facing;
    _p.damage = 12;
    _p.life_frames = 90;
};