extends CharacterBody2D
class_name EnemyClass

@onready var raycast_right = $RaycastR
@onready var raycast_left = $RaycastL
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_player = $AudioStreamPlayer2D
@onready var animation = $AnimationPlayer

@export var stat_sheet: stats_sheet
@export var movement_behaviour: roaming_behaviour
@export var weaknesses: Array[weakness_type]
@export var animation_library = AnimationLibrary.new()

var health: int = 100: set = set_health, get = get_health
var speed: int : set = set_speed

var direction = 1
var can_move = true

func _ready():
	set_speed(stat_sheet.speed)
	animation.add_animation_library("enemy_animations", animation_library)
	%GameManager.player_entity.sendDamage.connect(check_damage)

func _process(delta):
	if movement_behaviour != null && can_move:
		position.x += movement_behaviour.define_movement(self) * delta

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func check_damage(amount_of_dmg, damage_tag, source : CharacterClass, target_of_attack : EnemyClass):
	for i in weaknesses:
		if i.input_damage_tag == damage_tag and target_of_attack == self:
			set_health(i.receive_damage(amount_of_dmg, target_of_attack, source))

func set_health(new_value: int):
	health = new_value
	if (health <= 0):
		death_trigger()

func set_speed(new_value: int):
	speed = new_value

func get_health():
	return health

func death_trigger():
	can_move = false

func remove_from_scene():
	queue_free()
