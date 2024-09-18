extends CharacterBody2D
class_name CharacterClass

const speed = 130.0
const JUMP_VELOCITY = -300

@export var footsteps_sfx : AudioStream
@export var jump_sfx : AudioStream
@export var death_sfx : AudioStream

var footsteps_frames : Array = [1,5,9,11,15]

@onready var game_manager = %GameManager
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer2D

var direction

func apply_movements():
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Move character
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func switch_animations():
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

func jump_action():
	audio_stream_player.stream = jump_sfx
	audio_stream_player.play()
	velocity.y = JUMP_VELOCITY

func check_squash():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)

		if collision.get_collider() == null:
			continue
		
		if  collision.get_collider().is_in_group("slimes"):
			var slime = collision.get_collider()
			if Vector2.UP.dot(collision.get_normal()) > 0.1:
				slime.check_damage("squash_damage", 0, self)

func bounce(strength):
	var bounced = false
	if bounced:
		return
	else:
		bounced = true
		print("bounce attempt")
		velocity.y = -strength

func death():
	print("you died!")
	audio_stream_player.stream = death_sfx
	audio_stream_player.play()
	Engine.time_scale = 0.5
	get_node("CollisionShape2D").queue_free()
	game_manager.timer.start()

func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.animation == "idle": return
	if animated_sprite.animation == "jump": return
	load_sfx(footsteps_sfx)
	if animated_sprite.frame in footsteps_frames:
		audio_stream_player.play()
