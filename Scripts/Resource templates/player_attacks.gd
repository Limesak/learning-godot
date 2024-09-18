extends Resource
class_name player_attack

@export var damage : int
@export var damage_tag : String

signal attackAttempt(damage, damage_tag, enemy_entity)

func define_attack(_player_entity :CharacterClass):
    return

func attack_connects(enemy_entity : EnemyClass):
    attackAttempt.emit(damage, damage_tag, enemy_entity)