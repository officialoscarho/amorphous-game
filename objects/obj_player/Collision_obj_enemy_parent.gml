if (other.state != ESTATE.DEAD && other.contact_damage > 0) {
    player_take_damage(other.contact_damage, other.x);
}
