extends Popup

func set_text(combination : Array[int], door_id : String):
	$MarginContainer/NinePatchRect/MarginContainer/Label.text = (
		"The door code has been updated to " + 
		"".join(combination) + 
		" for door " +
		door_id + "."
	)
