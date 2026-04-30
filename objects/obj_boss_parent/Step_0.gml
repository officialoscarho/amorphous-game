// === obj_boss_parent :: Step ===

if (global.scene_lock) {
    xsp = 0;
    return;
}
if (dead) {
    // Float upward then destroy in a short timer
    state_timer--;
    if (state_timer <= 0) {
        global.boss = noone;
        save_add_boss(boss_name);

        // Reward — children override boss_on_defeat to grant unlocks
        boss_on_defeat();

        instance_destroy();
    }
    return;
}

if (attack_timer > 0)     attack_timer--;
if (phase_timer > 0)      phase_timer--;
if (hurt_flash_timer > 0) hurt_flash_timer--;
if (state_timer > 0)      state_timer--;

// Phase transitions based on HP thresholds
var new_phase = phase;
var pct = hp / hp_max;
if (pct <= 0.66 && phase == 1) new_phase = 2;
if (pct <= 0.33 && phase == 2) new_phase = 3;
if (new_phase != phase) {
    phase = new_phase;
    boss_on_phase_change();
}

// Children override this. Default just walks toward player.
boss_ai();

// Apply movement (no tilemap collision — bosses live in arena rooms
// with floor/wall objects or wide open floor)
xsp = clamp(xsp, -8, 8);
ysp += grv;
if (ysp > 12) ysp = 12;
x += xsp;
y += ysp;

image_xscale = facing;
image_blend = (hurt_flash_timer > 0) ? c_red : c_white;