if (dead) exit;
if (ds_list_find_index(other.hit_ids, id) != -1) exit;
ds_list_add(other.hit_ids, id);
boss_take_damage(other.damage);
