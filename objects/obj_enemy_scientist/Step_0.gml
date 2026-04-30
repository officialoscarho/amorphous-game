event_inherited();
if (state != ESTATE.DEAD && state != ESTATE.HURT) {
    state = player_in_detect_range() ? ESTATE.FLEE : ESTATE.IDLE;
}
if (state == ESTATE.DEAD) sprite_index = spr_enemy_scientist_dead;
else if (state == ESTATE.HURT) sprite_index = spr_enemy_scientist_hurt;
else if (abs(xsp) > 0.1) sprite_index = spr_enemy_scientist_run;
else sprite_index = spr_enemy_scientist_idle;