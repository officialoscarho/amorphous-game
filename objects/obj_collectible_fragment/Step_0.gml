if (global.paused) exit;

if (save_has_fragment(fragment_id)) {
    instance_destroy();
    exit;
}

bob_t += 0.06;
y = bob_y + sin(bob_t) * 4;

if (!collected && instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    collected = true;
    save_add_fragment(fragment_id);

    var _text = fragment_text;
    if (_text == "") _text = fragment_text_get(fragment_id);
    if (instance_exists(obj_hud)) {
        var _hud = instance_find(obj_hud, 0);
        _hud.hud_show_fragment(_text);
    }

    instance_destroy();
}