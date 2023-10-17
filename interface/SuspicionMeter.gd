extends TextureProgressBar

@export var suspicion_multiplier : int = 3


func _ready():
	value = 0
	max_value = 100
	step = .25


func _process(_delta):
	value -= step


func player_seen():
	value += step * suspicion_multiplier
	if value == max_value:
		end_game()


func end_game():
	get_tree().quit()
