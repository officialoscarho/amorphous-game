// === obj_boss_parent :: Collision with obj_attack_hitbox ===
if (dead) exit;
hp -= other.damage;
hurt_flash_timer = 6;
if (hp <= 0) {
    hp = 0;
    dead = true;
    state_timer = 60;
    xsp = 0;
    ysp = -6;
}