fragment_text = "";
fragment_timer = 0;
prompt_text = "";
prompt_timer = 0;
death_menu_index = 0;
death_menu_items = ["Respawn", "Main Menu"];

function hud_show_fragment(_text) {
    fragment_text = _text;
    fragment_timer = 360;
}

function hud_show_prompt(_text) {
    prompt_text = _text;
    prompt_timer = 240;
}
