extends Area2D

var can_click : bool = false


func _on_body_entered(body):
	if body.collision_layer == 1:  #player set to collision layer 1
		can_click = true
	else:
		print("opened")
		open()


func _on_body_exited(body):
	if body.collision_layer == 1:
		can_click = false


func _on_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_click:
		open()


func open():
	$AnimationPlayer.play("open")
