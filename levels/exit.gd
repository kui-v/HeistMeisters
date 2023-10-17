extends ColorRect

func _on_area_2d_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().quit()
