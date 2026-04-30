event_inherited();
if (state == ESTATE.DEAD) sprite_index = spr_enemy_soldier_dead;
else if (state == ESTATE.HURT) sprite_index = spr_enemy_soldier_hurt;
else if (state == ESTATE.ATTACK) sprite_index = spr_enemy_soldier_attack;
else if (abs(xsp) > 0.1) sprite_index = spr_enemy_soldier_walk;
else sprite_index = spr_enemy_soldier_idle;