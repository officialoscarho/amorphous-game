if (!global.gameplay_active) exit;

if (keyboard_check_pressed(vk_escape)) {
    global.paused = !global.paused;
    menu_index = 0;
}

if (!global.paused) exit;

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
            global.paused = false;
            break;
        case 1:
            global.paused = false;
            game_continue();
            break;
        case 2:
            game_return_to_title();
            break;
    }
}