if (!global.gameplay_active) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _hp_pct = global.player_health / max(1, global.player_health_max);
draw_set_color(c_black);
draw_rectangle(20, 20, 220, 42, false);
draw_set_color(c_red);
draw_rectangle(22, 22, 22 + 196 * _hp_pct, 40, false);
draw_set_color(c_white);
draw_text(28, 24, "HP " + string(global.player_health) + " / " + string(global.player_health_max));

var _en_pct = global.player_energy / max(1, global.player_energy_max);
draw_set_color(c_black);
draw_rectangle(20, 52, 220, 70, false);
draw_set_color(make_color_rgb(80, 200, 255));
draw_rectangle(22, 54, 22 + 196 * _en_pct, 68, false);
draw_set_color(c_white);
draw_text(28, 52, "EN " + string(global.player_energy));

draw_set_halign(fa_right);
draw_text(_gw - 20, 24, "Fragments: " + string(array_length(global.save.fragments_collected)) + " / " + string(MEMORY_FRAGMENT_COUNT));
draw_set_halign(fa_left);

if (global.boss != noone && instance_exists(global.boss)) {
    var _bw = _gw - 200;
    var _bx = 100;
    var _by = _gh - 64;
    var _pct = global.boss.hp / max(1, global.boss.hp_max);

    draw_set_color(c_black);
    draw_rectangle(_bx - 4, _by - 4, _bx + _bw + 4, _by + 24, false);
    draw_set_color(c_red);
    draw_rectangle(_bx, _by, _bx + _bw * _pct, _by + 20, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_bx + _bw * 0.5, _by - 20, global.boss.boss_name);
    draw_set_halign(fa_left);
}

if (fragment_timer > 0) {
    var _fy = _gh * 0.5;
    draw_set_color(make_color_rgb(12, 12, 20));
    draw_rectangle(80, _fy - 120, _gw - 80, _fy + 120, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_ext(_gw * 0.5, _fy, fragment_text, -1, _gw - 200);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (prompt_timer > 0) {
    draw_set_color(c_black);
    var _pw = 520;
    var _px = (_gw - _pw) * 0.5;
    draw_rectangle(_px, 84, _px + _pw, 118, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_px + _pw * 0.5, 92, prompt_text);
    draw_set_halign(fa_left);
}