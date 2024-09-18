extends weakness_type
class_name squash_damage

@export var squash_sound : AudioStream
@export var bounce_strenght : int
@export var input_damage_tag : String

func receive_damage(amount_of_dmg, enemy, source):
    if source != null:
        source.bounce(bounce_strenght)
    play_react_anim_and_audio(enemy, squash_sound, "squish")
    return amount_of_dmg