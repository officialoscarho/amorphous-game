if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    menu_index = (menu_index + 1) mod array_length(menu_items);
}

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    menu_index--;
    if (menu_index < 0) menu_index = array_length(menu_items) - 1;
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    switch (menu_index) {
        case 0:
            game_start_new();
            break;
        case 1:
            if (save_has_file()) game_continue();
            break;
        case 2:
            room_goto(rm_memory_log);
            break;
        case 3:
            game_end();
            break;
    }
}