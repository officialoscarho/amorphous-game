if (global.paused) exit;

sprite_index = activated ? spr_nest_active : spr_nest_inactive;

if (!activated && instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    activated = true;
    game_register_checkpoint(x, y);
    with (obj_player) {
        player_gain_health(global.player_health_max);
        player_gain_energy(20);
    }
    if (instance_exists(obj_hud)) with (obj_hud) hud_show_prompt("Nest formed. Checkpoint saved.");
}