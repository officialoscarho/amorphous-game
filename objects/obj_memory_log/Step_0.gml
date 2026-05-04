if (keyboard_check_pressed(vk_escape)) room_goto(rm_title);

if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    selected = (selected + 1) mod array_length(fragment_ids);
}

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    selected--;
    if (selected < 0) selected = array_length(fragment_ids) - 1;
}