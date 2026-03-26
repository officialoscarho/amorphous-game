// --- INPUT ---
// Basic Locomotion
var move = (keyboard_check(vk_right) || keyboard_check(ord("D"))) 
		- (keyboard_check(vk_left) || keyboard_check(ord("A")));

if move != 0 { facing = move; }
xsp = move * move_spd;

// Jump Func
if (keyboard_check_pressed(vk_space) && jumps_left > 0) {
	ysp = jump_force;
	jumps_left--;
}

// Attack Func
if attack_cooldown > 0 { attack_cooldown--; }

if (mouse_check_button_pressed(mb_left) && attack_cooldown == 0) {
    attack_cooldown = attack_cooldown_max;
    // Create attack hitbox based on player orientation
    var atk = instance_create_layer(x + (32 * facing), y, "Instances", obj_attack_hitbox);
    atk.direction_facing = facing;
}

// --- PHYSICS ---
ysp += grv; // apply gravity every step

var max_fall_speed = 20;
if ysp > max_fall_speed {
	ysp = max_fall_speed;
}

// Tile Collision
if xsp != 0 {
	var check_x = x + xsp + (hsp > 0 ? bbox_right - x : bbox_left - x);
	var hit_top = tilemap_get_at_pixel(collision_layer, check_x, bbox_top);
	var hit_bottom = tilemap_get_at_pixel(collision_layer, check_x, bbox_bottom - 1);
	
	if hit_top != 0 || hit_bottom != 0 {
		while tilemap_get_at_pixel(collision_layer, x + sign(xsp) + (xsp > 0 ? bbox_right - x : bbox_left - x), bbox_top) == 0
		&& tilemap_get_at_pixel(collision_layer, x + sign(xsp) + (xsp > 0 ? bbox_right - x : bbox_left - x), bbox_bottom - 1) == 0 {
            x += sign(hsp);
		}
		xsp = 0;
	}
}

x += xsp; // Horizontal Move

on_ground = false; // Re-check Ground

if ysp != 0 {
	var check_y = y + ysp + (ysp > 0 ? bbox_bottom - y : bbox_top - y);
    
    var hit_left  = tilemap_get_at_pixel(collision_layer, bbox_left, check_y);
    var hit_right = tilemap_get_at_pixel(collision_layer, bbox_right - 1, check_y);
    
    if hit_left != 0 || hit_right != 0 {
        while tilemap_get_at_pixel(collision_layer, bbox_left,      y + sign(ysp) + (ysp > 0 ? bbox_bottom - y : bbox_top - y)) == 0
           && tilemap_get_at_pixel(collision_layer, bbox_right - 1, y + sign(ysp) + (ysp > 0 ? bbox_bottom - y : bbox_top - y)) == 0 {
            y += sign(ysp);
        }
        
        if ysp > 0 {
            on_ground = true;
            jumps_left = jumps_max; // Refresh double jump on landing.
        }
        ysp = 0;
    }
}

y += ysp;

if on_ground {
    coyote_timer = 6; // 6 frames of coyote time (0.1 seconds at 60fps)
} else {
    coyote_timer--;
    if coyote_timer < 0 { coyote_timer = 0; }
}

if y > room_height + 200 {
    global.player_health = global.player_max_health;
    
    // Move player to respawn point.
    x = global.respawn_x;
    y = global.respawn_y;
    
    // Kill all momentum so they don't arrive mid-fall.
    xsp = 0;
    ysp = 0;
}

// Attack input

if attack_cooldown > 0 { 
    attack_cooldown--;
}

if mouse_check_button_pressed(mb_left) && attack_cooldown == 0 {
    attack_cooldown = attack_cooldown_max; // Reset the cooldown timer.

    var atk = instance_create_layer(x + (32 * facing), y, "Instances", obj_attack_hitbox);
    atk.direction_facing = facing; 
}