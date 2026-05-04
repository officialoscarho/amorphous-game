event_inherited();
if (attack_vis_timer > 0) attack_vis_timer--;

if (dead) sprite_index = spr_boss_construction_dead;
else if (attack_vis_timer > 0) sprite_index = spr_boss_construction_attack;
else if (abs(xsp) > 0.1) sprite_index = spr_boss_construction_walk;
else sprite_index = spr_boss_construction_idle;