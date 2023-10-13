extends "res://characters/template_character.gd"

const FOV_TOLERANCE : int = 20
const RED : Color = Color(1.0,0.25,0.25)
const WHITE : Color = Color(1.0,1.0,1.0)

var Player # capital P player for object Player

func _ready():
	Player = get_node("../../../Player") # camera should always be in Level/Cameras/Camera
#	print(get_node("../../../Player").name)
#	Player = get_node("../Player")
#	print(get_tree().get_root().get_children()[0].name)


func _process(delta):
	if Player_in_fov():
		$Torch.color = RED
	else:
		$Torch.color = WHITE


func Player_in_fov():
	var npc_facing_direction : Vector2 = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player : Vector2 = (Player.position - global_position).normalized()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg_to_rad(FOV_TOLERANCE):
		return true
	else:
		return false
