var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(8, 10, 18));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(255, 130, 210));
draw_text(_gw * 0.5, 180, "END OF BUILD");
draw_set_color(c_white);
draw_text(_gw * 0.5, 230, "Id approaches the route to the UES Huygens.");
draw_text(_gw * 0.5, 280, "Fragments recovered: " + string(array_length(global.save.fragments_collected)) + " / " + string(MEMORY_FRAGMENT_COUNT));
draw_text(_gw * 0.5, 360, "Press ENTER to return to title.");
draw_set_halign(fa_left);