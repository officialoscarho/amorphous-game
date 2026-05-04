if (dead) exit;
if (ds_list_find_index(other.hit_ids, id) != -1) exit;
ds_list_add(other.hit_ids, id);

hp -= other.damage;
hurt_flash_timer = 6;
if (hp <= 0) {
    hp = 0;
    dead = true;
    state_timer = 60;
    xsp = 0;
}