// === obj_prompt_trigger :: Create ===
sprite_index = spr_transition; // reuse the invisible marker
visible = false;
fired = false;

// Per-run dedupe (resets on game launch)
if (!variable_global_exists("prompts_fired")) {
    global.prompts_fired = ds_map_create();
}