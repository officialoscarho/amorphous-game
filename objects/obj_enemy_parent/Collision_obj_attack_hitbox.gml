if (state == ESTATE.DEAD) exit;
if (ds_list_find_index(other.hit_ids, id) != -1) exit;
ds_list_add(other.hit_ids, id);
enemy_take_damage(other.damage, other.x);