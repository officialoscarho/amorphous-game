// === obj_boss_parent :: Collision with obj_player ===
if (dead) exit;
with (obj_player) player_take_damage(other.contact_damage, other.x);