extends "res://characters/template_character.gd"


func _physics_process(delta):
	update_movement()
	move_and_slide()


func update_movement():
	look_at(get_global_mouse_position()) # character look at mouse
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		velocity.y = clamp(velocity.y + SPEED, 0, MAX_SPEED) # velocity does not go past max speed or below min
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		velocity.y = clamp(velocity.y - SPEED, -MAX_SPEED, 0)
	else:
		velocity.y = lerp(velocity.y, 0.0, FRICTION) # velocity eases from x to y by speed friction
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x = clamp(velocity.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x = clamp(velocity.x - SPEED, -MAX_SPEED, 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)


func _input(event):
	if Input.is_action_just_pressed("torch_toggle"):
		$Torch.enabled = not $Torch.enabled
