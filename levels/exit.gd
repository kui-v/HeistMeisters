extends ColorRect

func _on_area_2d_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().change_scene_to_file("res://interface/victory.tscn")
