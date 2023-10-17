extends Node2D


var can_click : bool = false


func _on_area_2d_body_entered(body):
	can_click = true


func _on_area_2d_body_exited(body):
	can_click = false
	$CanvasLayer/ComputerPopup.hide()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
