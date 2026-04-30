function enemy_state_idle() {
    xsp = 0;
    if (player_in_detect_range()) state = ESTATE.ALERT;
}

function enemy_state_patrol() {
    xsp = facing * move_speed * 0.5;
    if (state_timer <= 0) {
        facing = -facing;
        state_timer = 60 + irandom(60);
    }
    if (player_in_detect_range()) state = ESTATE.ALERT;
}

function enemy_state_alert() {
    if (!instance_exists(obj_player)) return;

    var _dx = obj_player.x - x;
    facing = (_dx >= 0) ? 1 : -1;

    if (abs(_dx) <= attack_range && attack_timer <= 0) {
        state = ESTATE.ATTACK;
        state_timer = 20;
        attack_timer = attack_cooldown_max;
        enemy_perform_attack();
    } else {
        xsp = facing * move_speed;
    }
}

function enemy_state_attack() {
    xsp = 0;
    if (state_timer <= 0) state = ESTATE.ALERT;
}

function enemy_state_hurt() {
    if (hurt_timer > 0) hurt_timer--;
    else state = ESTATE.ALERT;
}

function enemy_state_dead() {
    xsp = 0;
    if (state_timer <= 0) {
        enemy_drop_loot();
        instance_destroy();
    }
}

function enemy_state_flee() {
    if (!instance_exists(obj_player)) return;
    var _dx = obj_player.x - x;
    facing = (_dx >= 0) ? -1 : 1;
    xsp = facing * move_speed * 1.4;
}

function enemy_take_damage(_amount, _from_x) {
    if (state == ESTATE.DEAD) return;

    hp -= _amount;
    hurt_flash_timer = 8;

    if (hp <= 0) {
        hp = 0;
        state = ESTATE.DEAD;
        state_timer = 30;
        ysp = -4;
        return;
    }

    var _dir = sign(x - _from_x);
    if (_dir == 0) _dir = -facing;
    xsp = _dir * ENEMY_KNOCKBACK_X;
    ysp = ENEMY_KNOCKBACK_Y;
    state = ESTATE.HURT;
    hurt_timer = ENEMY_HURT_FRAMES;
}

function enemy_drop_loot() {
    if (instance_exists(obj_player)) {
        with (obj_player) player_gain_energy(KILL_ENERGY_GAIN);
    }

    if (drop_table == "default") {
        var _roll = random(1);
        if (_roll < 0.20) {
            instance_create_layer(x, y, LAYER_INSTANCES, obj_pickup_health);
        } else if (_roll < 0.35) {
            instance_create_layer(x, y, LAYER_INSTANCES, obj_pickup_energy);
        }
    }
}

function player_in_detect_range() {
    if (!instance_exists(obj_player)) return false;
    return point_distance(x, y, obj_player.x, obj_player.y) <= detect_range;
}

function enemy_apply_physics() {
    ysp += grv;
    if (ysp > 12) ysp = 12;

    var _tilemap = layer_tilemap_get_id(LAYER_TILES);
    if (_tilemap == -1) {
        x += xsp;
        y += ysp;
        return;
    }

    if (xsp != 0) {
        var _edge_x = (xsp > 0) ? bbox_right - x : bbox_left - x;
        var _probe_x = x + xsp + _edge_x;
        if (
            tilemap_get_at_pixel(_tilemap, _probe_x, bbox_top) != 0 ||
            tilemap_get_at_pixel(_tilemap, _probe_x, bbox_bottom - 1) != 0
        ) {
            xsp = 0;
            facing = -facing;
        }
        x += xsp;
    }

    on_ground = false;
    if (ysp != 0) {
        var _edge_y = (ysp > 0) ? bbox_bottom - y : bbox_top - y;
        var _probe_y = y + ysp + _edge_y;
        if (
            tilemap_get_at_pixel(_tilemap, bbox_left, _probe_y) != 0 ||
            tilemap_get_at_pixel(_tilemap, bbox_right - 1, _probe_y) != 0
        ) {
            if (ysp > 0) on_ground = true;
            ysp = 0;
        }
        y += ysp;
    }
}

function enemy_perform_attack() {
}