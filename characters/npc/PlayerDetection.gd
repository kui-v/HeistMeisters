extends "res://characters/template_character.gd"

const FOV_TOLERANCE : int = 20
const MAX_DETECTION_RANGE : int = 640
const RED : Color = Color(1.0,0.25,0.25)
const WHITE : Color = Color(1.0,1.0,1.0)

# capital P player for object Player
@onready var Player : CharacterBody2D = get_tree().get_first_node_in_group("Player")


func _process(delta):
	if Player_in_fov() and Player_in_los():
		$Torch.color = RED
	else:
		$Torch.color = WHITE


func Player_in_fov():
	var npc_facing_direction : Vector2 = Vector2(1,0).rotated(global_rotation) #camera's direction
	var direction_to_Player : Vector2 = (Player.position - global_position).normalized() #angle to Player from camera
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg_to_rad(FOV_TOLERANCE):
		return true
	else:
		return false


func Player_in_los():
	var space : PhysicsDirectSpaceState2D = get_world_2d().direct_space_state # gets world's physics state
	var ray_parameters : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(global_position, Player.global_position, collision_mask, [self])
	var los_obstacle : Dictionary = space.intersect_ray(ray_parameters)
	if not los_obstacle:
		return false
	else:
		var distance_to_Player : float = Player.global_position.distance_to(global_position)
		var Player_in_range : bool = distance_to_Player < MAX_DETECTION_RANGE
		if los_obstacle.collider == Player and Player_in_range:
			return true
		else:
			return false
