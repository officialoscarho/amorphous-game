if (global.paused || global.scene_lock) {
    xsp = 0;
    return;
}

if (attack_timer > 0) attack_timer--;
if (hurt_flash_timer > 0) hurt_flash_timer--;
if (state_timer > 0) state_timer--;

switch (state) {
    case ESTATE.IDLE: enemy_state_idle(); break;
    case ESTATE.PATROL: enemy_state_patrol(); break;
    case ESTATE.ALERT: enemy_state_alert(); break;
    case ESTATE.ATTACK: enemy_state_attack(); break;
    case ESTATE.HURT: enemy_state_hurt(); break;
    case ESTATE.DEAD: enemy_state_dead(); break;
    case ESTATE.FLEE: enemy_state_flee(); break;
}

enemy_apply_physics();
image_xscale = facing;
image_alpha = 1;
image_blend = (hurt_flash_timer > 0) ? c_red : c_white;