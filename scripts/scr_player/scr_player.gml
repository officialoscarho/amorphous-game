// =====================================================
//  scr_player
//  All player logic lives here as named functions.
//  Call them from obj_player's Step event.
// =====================================================


// -----------------------------------------------------
//  player_move()
//  Handles left/right input and facing direction.
// -----------------------------------------------------
function player_move() {
    var move = 0;
    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) move =  1;
    if (keyboard_check(vk_left)  || keyboard_check(ord("A"))) move = -1;

    xsp = move * move_spd;
    if (move != 0) facing = move;
    image_xscale = facing; // flips sprite automatically
}


// -----------------------------------------------------
//  player_jump()
//  Double jump supported once global flag is set.
// -----------------------------------------------------
function player_jump() {
    if (keyboard_check_pressed(vk_space) && jumps_left > 0) {
        ysp = jump_force;
        jumps_left--;
    }
}


// -----------------------------------------------------
//  player_gravity()
//  Applies gravity and caps fall speed.
// -----------------------------------------------------
function player_gravity() {
    ysp += grv;
    if (ysp > 20) ysp = 20; // terminal velocity
}


// -----------------------------------------------------
//  player_collision_x()
//  Resolves horizontal tile collisions.
// -----------------------------------------------------
function player_collision_x() {
    if (xsp == 0) return; // nothing to check

    var check_x = x + xsp + (xsp > 0 ? bbox_right - x : bbox_left - x);

    var hit_top    = tilemap_get_at_pixel(collision_layer, check_x, bbox_top);
    var hit_bottom = tilemap_get_at_pixel(collision_layer, check_x, bbox_bottom - 1);

    if (hit_top != 0 || hit_bottom != 0) {
        while (
            tilemap_get_at_pixel(collision_layer, x + sign(xsp) + (xsp > 0 ? bbox_right - x : bbox_left - x), bbox_top)    == 0 &&
            tilemap_get_at_pixel(collision_layer, x + sign(xsp) + (xsp > 0 ? bbox_right - x : bbox_left - x), bbox_bottom - 1) == 0
        ) {
            x += sign(xsp);
        }
        xsp = 0;
    }

    x += xsp;
}


// -----------------------------------------------------
//  player_collision_y()
//  Resolves vertical tile collisions, sets on_ground.
// -----------------------------------------------------
function player_collision_y() {
    on_ground = false;

    if (ysp == 0) return;

    var check_y = y + ysp + (ysp > 0 ? bbox_bottom - y : bbox_top - y);

    var hit_left  = tilemap_get_at_pixel(collision_layer, bbox_left,      check_y);
    var hit_right = tilemap_get_at_pixel(collision_layer, bbox_right - 1, check_y);

    if (hit_left != 0 || hit_right != 0) {
        while (
            tilemap_get_at_pixel(collision_layer, bbox_left,      y + sign(ysp) + (ysp > 0 ? bbox_bottom - y : bbox_top - y)) == 0 &&
            tilemap_get_at_pixel(collision_layer, bbox_right - 1, y + sign(ysp) + (ysp > 0 ? bbox_bottom - y : bbox_top - y)) == 0
        ) {
            y += sign(ysp);
        }

        if (ysp > 0) {
            on_ground  = true;
            // Refresh jumps on landing
            jumps_left = global.has_double_jump ? jumps_max : 1;
        }
        ysp = 0;
    }

    y += ysp;
}


// -----------------------------------------------------
//  player_attack()
//  M1 spawns a hitbox in front of the player.
// -----------------------------------------------------
function player_attack() {
    if (attack_cooldown > 0) {
        attack_cooldown--;
        return;
    }

    if (mouse_check_button_pressed(mb_left)) {
        attack_cooldown = attack_cooldown_max;
        var atk = instance_create_layer(x + (32 * facing), y, "Instances", obj_attack_hitbox);
        atk.direction_facing = facing;
    }
}


// -----------------------------------------------------
//  player_respawn_check()
//  Resets to checkpoint if player falls out of room.
// -----------------------------------------------------
function player_respawn_check() {
    if (y > room_height + 200) {
        global.player_health = global.player_health_max;
        x   = global.respawn_x;
        y   = global.respawn_y;
        xsp = 0;
        ysp = 0;
        room_goto_name(global.respawn_room);
    }
}