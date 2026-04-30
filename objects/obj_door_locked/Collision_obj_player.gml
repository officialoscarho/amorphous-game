if (!is_open) {
    var _push = sign(other.x - x);
    if (_push == 0) _push = -other.facing;
    other.x += _push * 6;
    other.xsp = 0;
}