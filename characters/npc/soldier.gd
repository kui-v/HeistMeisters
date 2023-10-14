extends "res://characters/npc/PlayerDetection.gd"

@onready var navigation : NavigationAgent2D = get_node("NavigationAgent2D")
@onready var destinations : Node = get_tree().get_root().get_children()[0].get_node("Destinations")

var possible_destinations : Array[Node]
var path : Array[Vector2]
var motion


func _ready():
	randomize()
	possible_destinations = destinations.get_children()


func _on_timer_timeout():
	pass # Replace with function body.
