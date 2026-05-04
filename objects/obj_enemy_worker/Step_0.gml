event_inherited();
if (state == ESTATE.DEAD) sprite_index = spr_enemy_scientist_dead;
else if (state == ESTATE.HURT) sprite_index = spr_enemy_worker_hurt;
else if (state == ESTATE.ATTACK) sprite_index = spr_enemy_worker_attack;
else if (abs(xsp) > 0.1) sprite_index = spr_enemy_worker_walk;
else sprite_index = spr_mask_enemy_worker;