extends Resource
class_name weakness_type

func receive_damage( _amount_of_dmg : int, _enemy : EnemyClass, _source : CharacterClass):
    return

func play_react_anim_and_audio(enemy, sfx, animation_name):
    enemy.audio_player.stream = sfx
    enemy.audio_player.play()
    enemy.animation.play("enemy_animations" + "/" + animation_name)
    enemy.animated_sprite.play("hurting")
