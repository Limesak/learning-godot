extends roaming_behaviour
class_name wall_to_wall_roaming

var direction: int = 1

func define_movement(enemy :EnemyClass):
	if enemy.raycast_right.is_colliding():
		direction = -1
		enemy.animated_sprite.flip_h = true
	if enemy.raycast_left.is_colliding():
		direction = 1
		enemy.animated_sprite.flip_h = false

	return direction * enemy.speed