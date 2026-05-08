image_xscale = direction_facing * visual_scale;
image_yscale = visual_scale;

var _targets = ds_list_create();
var _count = collision_rectangle_list(
    x - hit_half_width,
    y + hit_top,
    x + hit_half_width,
    y + hit_bottom,
    obj_enemy_parent,
    false,
    true,
    _targets,
    false
);

for (var _i = 0; _i < _count; _i++) {
    var _enemy = _targets[| _i];
    if (!instance_exists(_enemy)) continue;
    if (_enemy.state == ESTATE.DEAD) continue;
    if (ds_list_find_index(hit_ids, _enemy) != -1) continue;

    ds_list_add(hit_ids, _enemy);
    var _damage = damage;
    var _from_x = x;
    with (_enemy) enemy_take_damage(_damage, _from_x);
}

ds_list_destroy(_targets);

var _bosses = ds_list_create();
var _boss_count = collision_rectangle_list(
    x - hit_half_width,
    y + hit_top,
    x + hit_half_width,
    y + hit_bottom,
    obj_boss_parent,
    false,
    true,
    _bosses,
    false
);

for (var _b = 0; _b < _boss_count; _b++) {
    var _boss = _bosses[| _b];
    if (!instance_exists(_boss)) continue;
    if (_boss.dead) continue;
    if (ds_list_find_index(hit_ids, _boss) != -1) continue;

    ds_list_add(hit_ids, _boss);
    var _boss_damage = damage;
    with (_boss) boss_take_damage(_boss_damage);
}

ds_list_destroy(_bosses);

life_frames--;
if (life_frames <= 0) instance_destroy();
