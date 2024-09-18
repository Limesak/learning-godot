extends weakness_type
class_name squash_damage

@export var squash_sound : AudioStream
@export var bounce_strenght : int

func receive_damage(dmg_tag, _amount_of_dmg, sprites_anim, audio_player, animation, source):
    if dmg_tag == "squash_damage":
        if source != null:
            source.bounce(bounce_strenght)
        audio_player.stream = squash_sound
        animation.play("squish")
        audio_player.play()
        sprites_anim.play("hurting")
        return _amount_of_dmg
