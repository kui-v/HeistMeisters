extends Popup

signal combination_correct

var combination : Array[int] = [0,4,5,1]
var guess : Array[int]

@onready var display : Label = $MarginContainer/VBoxContainer/DisplayContainer/Display
@onready var status : TextureRect = $MarginContainer/VBoxContainer/ButtonContainer/GridContainer/StatusLight
@onready var buttons : GridContainer = $MarginContainer/VBoxContainer/ButtonContainer/GridContainer

func _ready():
	connect_buttons()


func connect_buttons():
	for child in buttons.get_children():
		if child is Button: #not a status light
			child.pressed.connect(button_pressed.bind(child.text))


func button_pressed(text):
	if text != "OK" and guess.size() < 4:
		enter(int(text))
	elif text == "OK":
		check_guess()
	else:
		reset_lock()
	display_guess()


func check_guess():
	if guess == combination:
		combination_correct.emit()
		$AnimationPlayer.play("flash_correct")
	else:
		reset_lock()


func enter(num):
	guess.push_back(num)
	$AnimationPlayer.play("flash_input")


func reset_lock():
	$AnimationPlayer.play("flash_incorrect")
	guess.clear()


func display_guess():
	var displayed_text : String
	for i in guess:
		displayed_text += str(i)
	display.text = displayed_text


func _on_popup_hide():
	guess.clear()
	display.text = ""
