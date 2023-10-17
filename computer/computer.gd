extends Node2D

var can_click : bool = false
var combination : Array[int]
var door_id : String
@export var combination_length : int = 4


signal door_combination


func _ready():
	generate_combination()
	print("1", combination, door_id)
	emit_signal("door_combination", combination, door_id)


func generate_combination():
	combination = CombinationGenerator.generate_combination(combination_length)
	door_id = str(randi() % 100)
	set_popup_text()


func set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination, door_id)


func _on_area_2d_body_entered(body):
	can_click = true 


func _on_area_2d_body_exited(body):
	can_click = false
	$CanvasLayer/ComputerPopup.hide()
	$PointLight2D.enabled = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
		$PointLight2D.enabled = true
