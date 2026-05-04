if (global.paused || fired) exit;
if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    fired = true;
    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt(other.prompt_text);
}