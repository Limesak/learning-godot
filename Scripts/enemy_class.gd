extends CharacterBody2D
class_name EnemyClass

@onready var raycast_right = $RaycastR
@onready var raycast_left = $RaycastL
@onready var animated_sprite = $AnimatedSprite2D

@export var stat_sheet: stats_sheet
@export var movement_behaviour: roaming_behaviour

var health: int = 100: set = set_health, get = get_health
var speed: int : set = set_speed

var direction = 1

func _ready():
	set_speed(stat_sheet.speed)

func _process(delta):
	if movement_behaviour != null:
		position.x += movement_behaviour.define_movement(self) * delta

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func set_health(new_value: int):
	health = new_value

func set_speed(new_value: int):
	speed = new_value

func get_health():
	return health
