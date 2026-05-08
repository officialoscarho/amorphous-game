function player_apply_form_mask() {
    var _use_blob_mask = (state == PSTATE.BLOB || (state == PSTATE.HURT && hurt_return_state == PSTATE.BLOB));
    var _is_ducking = variable_instance_exists(id, "ducking") && ducking && !_use_blob_mask;
    var _humanoid_mask = player_humanoid_mask_get();

    if (_use_blob_mask || _is_ducking) {
        mask_index = spr_mask_player;
    } else {
        mask_index = _humanoid_mask;
    }
}

function player_humanoid_mask_get() {
    var _humanoid_mask = spr_mask_player_humanoid;

    if (sprite_get_bbox_bottom(_humanoid_mask) < sprite_get_height(_humanoid_mask) - 8) {
        _humanoid_mask = spr_player_humanoid_idle;
    }

    return _humanoid_mask;
}

function player_animate() {
    var _spr = spr_player_humanoid_idle;

    if (state == PSTATE.BLOB || (state == PSTATE.HURT && hurt_return_state == PSTATE.BLOB)) {
        if (state == PSTATE.HURT) {
            _spr = spr_player_blob_hurt;
        } else if (attack_anim_timer > 0) {
            _spr = spr_player_blob_attack;
        } else if (!on_ground) {
            _spr = (ysp < 0) ? spr_player_blob_jump : spr_player_blob_fall;
        } else if (abs(xsp) > 0.1) {
            _spr = spr_player_blob_run_loop;
        } else {
            _spr = spr_player_blob_idle;
        }
    } else if (state == PSTATE.DEAD) {
        _spr = spr_player_humanoid_dead;
    } else if (state == PSTATE.HURT) {
        _spr = spr_player_humanoid_hurt;
    } else if (state == PSTATE.DASHING) {
        _spr = spr_player_humanoid_run_start;
    } else if (attack_anim_timer > 0) {
        _spr = spr_player_humanoid_attack;
    } else if (shoot_anim_timer > 0) {
        _spr = spr_player_humanoid_attack;
    } else if (!on_ground) {
        _spr = (ysp < 0) ? spr_player_humanoid_jump : spr_player_humanoid_fall;
    } else if (abs(xsp) > 0.1) {
        _spr = spr_player_humanoid_run_loop;
    } else {
        _spr = spr_player_humanoid_idle;
    }

    sprite_index = _spr;
    player_apply_form_mask();
    
    image_xscale = facing;
    image_yscale = (variable_instance_exists(id, "ducking") && ducking && state == PSTATE.NORMAL) ? 0.72 : 1;

    if (invuln_frames > 0 && (invuln_frames mod 4 < 2)) {
        image_alpha = 0.35;
        image_blend = c_white;
    } else {
        image_alpha = 1.0;
        image_blend = c_white;
    }
}
