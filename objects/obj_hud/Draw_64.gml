if (!global.gameplay_active) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _pad = 32;

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _panel_x = _pad;
var _panel_y = _pad;
var _panel_w = 292;
var _panel_h = 94;

draw_set_alpha(0.86);
draw_set_color(make_color_rgb(5, 7, 12));
draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(92, 120, 150));
draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);

var _hp_pct = global.player_health / max(1, global.player_health_max);
var _bar_x = _panel_x + 20;
var _bar_y = _panel_y + 28;
var _bar_w = 236;
var _bar_h = 16;

draw_set_color(make_color_rgb(210, 226, 242));
draw_text(_bar_x, _panel_y + 10, "HP " + string(global.player_health) + " / " + string(global.player_health_max));
draw_set_color(make_color_rgb(24, 28, 36));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
draw_set_color(make_color_rgb(220, 52, 72));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w * _hp_pct, _bar_y + _bar_h, false);
draw_set_color(make_color_rgb(255, 226, 230));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

var _en_pct = global.player_energy / max(1, global.player_energy_max);
_bar_y = _panel_y + 66;

draw_set_color(make_color_rgb(210, 226, 242));
draw_text(_bar_x, _panel_y + 48, "EN " + string(global.player_energy) + " / " + string(global.player_energy_max));
draw_set_color(make_color_rgb(24, 28, 36));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
draw_set_color(make_color_rgb(80, 200, 255));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w * _en_pct, _bar_y + _bar_h, false);
draw_set_color(make_color_rgb(218, 248, 255));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

var _frag_w = 244;
var _frag_x = _gw - _pad - _frag_w;
var _frag_y = _pad;

draw_set_alpha(0.82);
draw_set_color(make_color_rgb(5, 7, 12));
draw_rectangle(_frag_x, _frag_y, _frag_x + _frag_w, _frag_y + 42, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(92, 120, 150));
draw_rectangle(_frag_x, _frag_y, _frag_x + _frag_w, _frag_y + 42, true);
draw_set_color(make_color_rgb(230, 238, 248));
draw_set_halign(fa_right);
draw_text(_frag_x + _frag_w - 16, _frag_y + 12, "Fragments " + string(array_length(global.save.fragments_collected)) + " / " + string(MEMORY_FRAGMENT_COUNT));
draw_set_halign(fa_left);

if (global.boss != noone && instance_exists(global.boss)) {
    var _bw = clamp(_gw * 0.42, 320, 560);
    var _bx = (_gw - _bw) * 0.5;
    var _by = 52;
    var _pct = global.boss.hp / max(1, global.boss.hp_max);

    draw_set_alpha(0.86);
    draw_set_color(make_color_rgb(5, 7, 12));
    draw_rectangle(_bx - 12, _by - 28, _bx + _bw + 12, _by + 30, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(92, 120, 150));
    draw_rectangle(_bx - 12, _by - 28, _bx + _bw + 12, _by + 30, true);
    draw_set_color(make_color_rgb(220, 52, 72));
    draw_rectangle(_bx, _by, _bx + _bw * _pct, _by + 18, false);
    draw_set_color(make_color_rgb(255, 226, 230));
    draw_rectangle(_bx, _by, _bx + _bw, _by + 18, true);
    draw_set_color(make_color_rgb(230, 238, 248));
    draw_set_halign(fa_center);
    draw_text(_bx + _bw * 0.5, _by - 20, global.boss.boss_name);
    draw_set_halign(fa_left);
}

if (fragment_timer > 0) {
    var _fy = _gh * 0.5;
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(5, 7, 12));
    draw_rectangle(96, _fy - 132, _gw - 96, _fy + 132, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(92, 120, 150));
    draw_rectangle(96, _fy - 132, _gw - 96, _fy + 132, true);
    draw_set_color(make_color_rgb(230, 238, 248));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_ext(_gw * 0.5, _fy, fragment_text, -1, _gw - 240);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (prompt_timer > 0) {
    var _pw = min(620, _gw - _pad * 2);
    var _px = (_gw - _pw) * 0.5;
    var _py = _gh - 98;

    draw_set_alpha(0.86);
    draw_set_color(make_color_rgb(5, 7, 12));
    draw_rectangle(_px, _py, _px + _pw, _py + 44, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(92, 120, 150));
    draw_rectangle(_px, _py, _px + _pw, _py + 44, true);
    draw_set_color(make_color_rgb(230, 238, 248));
    draw_set_halign(fa_center);
    draw_text(_px + _pw * 0.5, _py + 14, prompt_text);
    draw_set_halign(fa_left);
}

if (variable_global_exists("death_menu_active") && global.death_menu_active) {
    draw_set_alpha(0.72);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    var _mw = min(420, _gw - 64);
    var _mx = (_gw - _mw) * 0.5;
    var _my = _gh * 0.5 - 116;

    draw_set_color(make_color_rgb(8, 10, 18));
    draw_rectangle(_mx, _my, _mx + _mw, _my + 232, false);
    draw_set_color(make_color_rgb(92, 120, 150));
    draw_rectangle(_mx, _my, _mx + _mw, _my + 232, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 226, 230));
    draw_text(_gw * 0.5, _my + 28, "You Died");

    for (var _i = 0; _i < array_length(death_menu_items); _i++) {
        var _iy = _my + 92 + _i * 52;
        draw_set_color((_i == death_menu_index) ? make_color_rgb(40, 40, 60) : make_color_rgb(18, 18, 28));
        draw_rectangle(_mx + 64, _iy - 10, _mx + _mw - 64, _iy + 32, false);
        draw_set_color((_i == death_menu_index) ? c_yellow : c_white);
        draw_text(_gw * 0.5, _iy, death_menu_items[_i]);
    }

    draw_set_halign(fa_left);
}

draw_set_alpha(1);
draw_set_valign(fa_top);
