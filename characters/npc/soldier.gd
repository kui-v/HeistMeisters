# Pathfinding logic
# 1. Get a random Marker2D for guard to pathfind to
# 2. Set marker's position in NavigationAgent2D
# 3. Start guard movement to position
# 4. On NavigationAgent2D signal navigation_finished(), start timer
# 5. On Timer signal timeout(), stop the timer, get new path, and set navigation_agent's target to that

extends "res://characters/npc/PlayerDetection.gd"

@onready var navigation_agent : NavigationAgent2D = get_node("NavigationAgent2D")
@onready var destinations : Node = get_tree().get_first_node_in_group("Destinations")

@export var minimum_arrival_distance : float = 100.0
@export var walk_speed : float = 50
@export var movement_target : Node2D

var possible_destinations : Array[Node]
const SMOOTH_SPEED : float = 2.0

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	navigation_agent.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	call_deferred("actor_setup")
	print(get_tree().get_root().find_children("Destinations"))


func actor_setup():
	await get_tree().physics_frame
	randomize()
	possible_destinations = destinations.get_children()
	movement_target = possible_destinations[randi() % possible_destinations.size() - 1]
	set_movement_target(movement_target.position)


func set_movement_target(target_point : Vector2):
	navigation_agent.target_position = target_point


func _physics_process(delta):
	if $Timer.is_stopped():
		var current_agent_position : Vector2 = global_position
		var next_path_position : Vector2 = navigation_agent.get_next_path_position()
		var new_velocity : Vector2 = next_path_position - current_agent_position
		new_velocity = new_velocity.normalized()
		new_velocity *= walk_speed
		velocity = new_velocity
		
		rotation = lerp_angle(rotation, current_agent_position.angle_to_point(next_path_position), delta * SMOOTH_SPEED)
		move_and_slide()
		
		if is_on_wall(): # if hit obstacle, choose another path
			make_path()


func make_path():
	possible_destinations = destinations.get_children()
	movement_target = possible_destinations[randi() % possible_destinations.size() - 1]
	set_movement_target(movement_target.position)


func _on_timer_timeout():
	$Timer.stop() # same as having one-shot selected in Timer
	make_path()


func _on_navigation_agent_2d_navigation_finished():
	$Timer.start()
