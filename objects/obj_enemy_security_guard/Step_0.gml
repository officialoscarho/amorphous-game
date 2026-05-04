event_inherited();
if (state == ESTATE.DEAD) sprite_index = spr_enemy_guard_shoot;
else if (state == ESTATE.HURT) sprite_index = spr_enemy_guard_hurt;
else if (state == ESTATE.ATTACK) sprite_index = spr_enemy_guard_dead;
else if (abs(xsp) > 0.1) sprite_index = spr_enemy_guard_walk;
else sprite_index = spr_enemy_guard_idle;