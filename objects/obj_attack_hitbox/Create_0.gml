damage = PLAYER_ATTACK_DAMAGE;
life_frames = 8;
direction_facing = 1;
range_scale = 1.0;

var _slash_sprite = asset_get_index("spr_player_slash");
sprite_index = (_slash_sprite == -1) ? spr_attack_hitbox : _slash_sprite;
mask_index = spr_attack_hitbox;
visible = true;
image_alpha = (_slash_sprite == -1) ? 0.35 : 0.9;
image_blend = (_slash_sprite == -1) ? make_color_rgb(255, 230, 80) : c_white;
hit_ids = ds_list_create();
