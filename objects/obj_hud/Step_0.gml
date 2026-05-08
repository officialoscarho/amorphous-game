if (variable_global_exists("room_transition_active") && global.room_transition_active) {
    game_update_room_transition();
    exit;
}

if (variable_global_exists("death_menu_active") && global.death_menu_active) {
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        death_menu_index = (death_menu_index + 1) mod array_length(death_menu_items);
    }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        death_menu_index--;
        if (death_menu_index < 0) death_menu_index = array_length(death_menu_items) - 1;
    }

    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        switch (death_menu_index) {
            case 0:
                player_do_respawn();
                break;
            case 1:
                game_return_to_title();
                break;
        }
    }
    exit;
}

if (fragment_timer > 0 && !global.paused) fragment_timer--;
if (prompt_timer > 0 && !global.paused) prompt_timer--;
