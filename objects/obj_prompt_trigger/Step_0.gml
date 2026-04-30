// === obj_prompt_trigger :: Step ===
if (fired) exit;
if (ds_map_exists(global.prompts_fired, prompt_id)) {
    fired = true;
    exit;
}
if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    fired = true;
    ds_map_set(global.prompts_fired, prompt_id, true);
    with (obj_hud) hud_show_prompt(other.prompt_text);
}