extends "res://doors/door.gd"

@onready var timer = $CanvasLayer/Timer

func _on_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()


func _on_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()


func _on_numpad_combination_correct():
	open()
	timer.start()

func _on_timer_timeout():
	$CanvasLayer/Numpad.hide()
