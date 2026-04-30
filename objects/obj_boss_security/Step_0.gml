// === obj_boss_security :: Step ===
event_inherited();

if (dead) {
    sprite_index = spr_boss_security_dead;
} else if (state_timer > 50) {
    sprite_index = spr_boss_security_attack;
} else if (abs(xsp) > 0.1) {
    sprite_index = spr_boss_security_walk;
} else {
    sprite_index = spr_boss_security_idle;
}