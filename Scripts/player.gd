extends CharacterClass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_action()

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")

	switch_animations()

	apply_movements()

	move_and_slide()