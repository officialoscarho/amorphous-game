var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(8, 10, 18));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(255, 130, 210));
draw_text(_gw * 0.5, 130, "AMORPHOUS");

draw_set_color(c_white);
draw_text(_gw * 0.5, 170, "Prologue + Level 1 + Level 2 Build");

for (var _i = 0; _i < array_length(menu_items); _i++) {
    var _disabled = ((menu_items[_i] == "Continue" || menu_items[_i] == "Delete Save") && !save_has_file());
    var _y = 260 + _i * 52;

    draw_set_color((_i == menu_index) ? make_color_rgb(40, 40, 60) : make_color_rgb(18, 18, 28));
    draw_rectangle(_gw * 0.5 - 160, _y - 10, _gw * 0.5 + 160, _y + 32, false);

    if (_disabled) draw_set_color(c_gray);
    else draw_set_color((_i == menu_index) ? c_yellow : c_white);

    draw_text(_gw * 0.5, _y, menu_items[_i]);
}

if (message_timer > 0) {
    draw_set_color(make_color_rgb(210, 226, 242));
    draw_text(_gw * 0.5, 260 + array_length(menu_items) * 52 + 16, message_text);
}

draw_set_halign(fa_left);
