var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(8, 10, 18));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_color(c_white);
draw_text(60, 40, "MEMORY LOG");
draw_text(60, _gh - 50, "UP/DOWN select     ESC return");

for (var _i = 0; _i < array_length(fragment_ids); _i++) {
    var _id = fragment_ids[_i];
    var _collected = save_has_fragment(_id);
    draw_set_color((_i == selected) ? c_yellow : (_collected ? c_white : c_gray));
    var _title = _collected ? fragment_title_get(_id) : "????";
    draw_text(80, 110 + _i * 34, _title);
}

var _selected_id = fragment_ids[selected];
draw_set_color(c_white);
draw_rectangle(420, 100, _gw - 80, _gh - 90, true);

if (save_has_fragment(_selected_id)) {
    draw_text(450, 120, fragment_title_get(_selected_id));
    draw_text_ext(450, 160, fragment_text_get(_selected_id), 22, _gw - 560);
} else {
    draw_text(450, 120, "Fragment not recovered.");
}