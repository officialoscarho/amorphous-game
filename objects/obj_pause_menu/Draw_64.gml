if (!global.gameplay_active || !global.paused) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.75);
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_gw * 0.5, 180, "PAUSED");

for (var _i = 0; _i < array_length(menu_items); _i++) {
    draw_set_color((_i == menu_index) ? c_yellow : c_white);
    draw_text(_gw * 0.5, 260 + _i * 44, menu_items[_i]);
}

draw_set_halign(fa_left);