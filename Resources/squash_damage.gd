extends weakness_type
class_name squash_damage

func receive_damage(damage_tag, _amount_of_damage):
    if damage_tag == "squash_damage":
        return 0