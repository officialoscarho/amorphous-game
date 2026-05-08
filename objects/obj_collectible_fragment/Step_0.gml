if (global.paused) exit;

if (fragment_id != "" && save_has_fragment(fragment_id)) {
    instance_destroy();
    exit;
}

bob_t += 0.06;
y = bob_y + sin(bob_t) * 4;

if (!collected && instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    collected = true;

    var _text = fragment_text;
    if (_text == "") _text = fragment_text_get(fragment_id);
    if (fragment_id != "") {
        save_add_fragment(fragment_id);
    } else {
        show_debug_message("Collectible fragment missing fragment_id in " + room_get_name(room));
    }
    if (instance_exists(obj_hud)) {
        var _hud = instance_find(obj_hud, 0);
        _hud.hud_show_fragment(_text);
    }

    instance_destroy();
}
