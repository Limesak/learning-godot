extends player_attack
class_name  squash_attack

func define_attack(player_entity):
    for index in range(player_entity.get_slide_collision_count()):
        var collision = player_entity.get_slide_collision(index)
        if collision.get_collider() == null:
            continue

        if collision.get_collider().is_in_group("Enemies") and Vector2.UP.dot(collision.get_normal()) > 0.1:
            attack_connects(collision.get_collider())