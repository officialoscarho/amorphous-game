function player_take_damage(_amount, _from_x) {
    if (state == PSTATE.DEAD) return;
    if (state == PSTATE.HURT) return;
    if (invuln_frames > 0) return;

    global.player_health -= _amount;
    invuln_frames = PLAYER_INVULN_FRAMES;

    if (global.player_health <= 0) {
        global.player_health = 0;
        state = PSTATE.DEAD;
        death_timer = 60;
        xsp = 0;
        ysp = -6;
        return;
    }

    state = PSTATE.HURT;
    hurt_frames = 18;
    var _dir = sign(x - _from_x);
    if (_dir == 0) _dir = -facing;
    xsp = _dir * 6;
    ysp = -5;
}

function player_gain_energy(_amount) {
    global.player_energy = min(global.player_energy + _amount, global.player_energy_max);
}

function player_gain_health(_amount) {
    global.player_health = min(global.player_health + _amount, global.player_health_max);
}