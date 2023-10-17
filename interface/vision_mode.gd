extends CanvasModulate

const DARK : Color = Color("111111")
const NIGHT_VISION : Color = Color("37bf62")

@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var vision_cooldown_timer : Timer = $VisionCooldown

var night_vision_toggle_available : bool = true


func _ready():
	visible = true # keep it hidden while editing level
	color = DARK


func cycle_vision_mode():
	if night_vision_toggle_available:
		if color == DARK:
			night_vision_mode()
		else:
			dark_mode()
		vision_cooldown_timer.start()
		night_vision_toggle_available = false


func dark_mode():
	color = DARK
	audio.stream = load("res://assets/SFX/nightvision_off.wav")
	audio.play()
	get_tree().call_group("lights", "show")


func night_vision_mode():
	color = NIGHT_VISION
	audio.stream = load("res://assets/SFX/nightvision.wav")
	audio.play()
	get_tree().call_group("lights", "hide")


func _on_vision_cooldown_timeout():
	vision_cooldown_timer.stop()
	night_vision_toggle_available = true
