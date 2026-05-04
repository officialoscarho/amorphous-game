if (global.paused) exit;

cycle_t++;
if (cycle_t >= cycle_period) cycle_t = 0;

var _phase = cycle_t / cycle_period;
if (_phase < 0.60) {
    y = start_y;
} else {
    var _slam = (_phase - 0.60) / 0.40;
    y = start_y + sin(_slam * pi) * slam_distance;
}