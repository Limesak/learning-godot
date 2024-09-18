extends Node

var score = 0

var level_gravity = 50

@onready var timer = $Timer
@onready var score_label = $"Score label"

@export var player_entity: CharacterClass

func add_point():
	score += 1
	score_label.text = "You've collected \n" + str(score) + " coins!"

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
