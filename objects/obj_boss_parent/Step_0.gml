if (global.paused || global.scene_lock) {
    xsp = 0;
    return;
}

if (dead) {
    state_timer--;
    if (state_timer <= 0) {
        global.boss = noone;
        save_add_boss(boss_id);
        boss_defeat_action();
        instance_destroy();
    }
    return;
}

if (attack_timer > 0) attack_timer--;
if (phase_timer > 0) phase_timer--;
if (hurt_flash_timer > 0) hurt_flash_timer--;
if (state_timer > 0) state_timer--;

var _pct = hp / hp_max;
if (_pct <= 0.66 && phase == 1) {
    phase = 2;
    boss_phase_change_action();
}
if (_pct <= 0.33 && phase == 2) {
    phase = 3;
    boss_phase_change_action();
}

if (!arena_floor_resolved) {
    arena_floor_y = boss_find_floor_y();
    y = arena_floor_y;
    arena_floor_resolved = true;
}

boss_ai_action();

xsp = clamp(xsp, -8, 8);
boss_apply_horizontal_collision();
y = arena_floor_y;
ysp = 0;

image_xscale = facing * sprite_face_sign;
image_alpha = 1;
image_blend = (hurt_flash_timer > 0) ? c_red : c_white;
