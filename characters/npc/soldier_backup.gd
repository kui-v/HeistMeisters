extends "res://characters/npc/PlayerDetection.gd"

@onready var navigation : NavigationAgent2D = get_node("NavigationAgent2D")
@onready var destinations : Node = get_tree().get_root().get_children()[0].get_node("Destinations")

var possible_destinations : Array[Node]
var path : Vector2
var motion

@export var minimum_arrival_distance : int = 5 #5 pixels
@export var walk_speed : float = 0.5

func _ready():
	$Timer.start
	randomize()
	possible_destinations = destinations.get_children()
	make_path()

func _physics_process(delta):
	var dir = to_local(navigation.get_next_path_position()).normalized()
	velocity = 50 * dir
	var distance_to_destination = position.distance_to(path)
	if distance_to_destination > minimum_arrival_distance:
		move_and_slide()
	else:
		update_path()

func update_path():
	if $Timer.stopped():
		$Timer.start()
	else:
		navigation.get_next_path_position()

func make_path():
	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
	navigation.target_position = new_destination.position

func _on_timer_timeout():
	make_path()





#func _physics_process(delta):
##	var dir = to_local(navigation.get_next_path_position()).normalized()
##	velocity = dir * SPEED
##	move_and_slide()
##	print(navigation.get_next_path_position())
#	navigation.get_next_path_position()
#	navigate()
#
#
#func navigate():
#	var distance_to_destination = position.distance_to(path)
#	if distance_to_destination > minimum_arrival_distance:
#		move()
#	else:
#		update_path()
#
#
#func move():
#	look_at(path)
#	velocity = (path - position).normalized() * MAX_SPEED
#	move_and_slide()
#
#
#func update_path():
#	if $Timer.is_stopped():
#		$Timer.start
#	else:
#		navigation.target_position = path
#
#
#func make_path():
#	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
#	print(new_destination)
#	path = new_destination.position
##	navigation.target_position = path
#
#

