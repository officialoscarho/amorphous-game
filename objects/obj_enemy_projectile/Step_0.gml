if (global.paused) exit;

if (!variable_instance_exists(id, "is_player_projectile")) is_player_projectile = false;
if (!variable_instance_exists(id, "visual_scale")) visual_scale = ENEMY_PROJECTILE_VISUAL_SCALE;

x += speed_x * direction_facing;
image_xscale = direction_facing * visual_scale;
image_yscale = visual_scale;

life_frames--;
if (life_frames <= 0) {
    instance_destroy();
    exit;
}

if (is_player_projectile) {
    var _targets = ds_list_create();
    var _count = collision_rectangle_list(
        bbox_left,
        bbox_top,
        bbox_right,
        bbox_bottom,
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

        var _damage = damage;
        var _from_x = x;
        with (_enemy) enemy_take_damage(_damage, _from_x);
        ds_list_destroy(_targets);
        instance_destroy();
        exit;
    }
    ds_list_destroy(_targets);

    var _bosses = ds_list_create();
    var _boss_count = collision_rectangle_list(
        bbox_left,
        bbox_top,
        bbox_right,
        bbox_bottom,
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

        var _boss_damage = damage;
        with (_boss) boss_take_damage(_boss_damage);
        ds_list_destroy(_bosses);
        instance_destroy();
        exit;
    }
    ds_list_destroy(_bosses);
} else if (place_meeting(x, y, obj_player)) {
    with (obj_player) player_take_damage(other.damage, other.x);
    instance_destroy();
    exit;
}

var _tilemap = layer_tilemap_get_id(LAYER_TILES);
if (_tilemap != -1 && tilemap_get_at_pixel(_tilemap, x, y) != 0) {
    instance_destroy();
}
