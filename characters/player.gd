extends "res://characters/template_character.gd"

const PLAYER_SPRITE : String = "res://assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE : String = "res://assets/GFX/PNG/Tiles/tile_130.png"
const PLAYER_OCCLUDER : String = "res://characters/human_occluder.tres"
const BOX_OCCLUDER : String = "res://characters/box_occluder.tres"
const PLAYER_LIGHT : String = "res://assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_LIGHT : String = "res://assets/GFX/PNG/Tiles/tile_130.png"

var velocity_multiplier : int = 1
var is_disguised : bool = false
@export var disguise_duration : int = 5
@export var disguise_slowdown : float = 0
@export var num_disguises : int = 3

func _ready():
	reveal()
	$DisguiseTimer.wait_time = disguise_duration
	get_tree().call_group("disguise_display", "update_disguises", num_disguises)


func _physics_process(delta):
	update_movement()
	move_and_slide()
	if is_disguised:
		$DisguiseLabel.text = str($DisguiseTimer.time_left).pad_decimals(2)
		$DisguiseLabel.rotation = -global_rotation


func update_movement():
	look_at(get_global_mouse_position()) # character look at mouse
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		velocity.y = clamp(velocity.y + SPEED, 0, MAX_SPEED) # velocity does not go past max speed or below min
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		velocity.y = clamp(velocity.y - SPEED, -MAX_SPEED, 0)
	else:
		velocity.y = lerp(velocity.y, 0.0, FRICTION) * velocity_multiplier # velocity eases from x to y by speed friction
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x = clamp(velocity.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x = clamp(velocity.x - SPEED, -MAX_SPEED, 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
	
	velocity *= velocity_multiplier


func _input(event):
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


func toggle_disguise():
	if is_disguised:
		reveal()
	elif num_disguises > 0:
		disguise()


func reveal():
	$Sprite2D.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)
	$PointLight2D.texture = load(PLAYER_LIGHT)
	$DisguiseLabel.hide()
	
	velocity_multiplier = 1
	is_disguised = false
	collision_layer = 1


func disguise():
	$DisguiseTimer.start()
	$Sprite2D.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	$PointLight2D.texture = load(BOX_LIGHT)
	$DisguiseLabel.show()
	
	num_disguises -= 1
	velocity_multiplier = disguise_slowdown
	is_disguised = true
	collision_layer = 16 #currently nothing set here
	
	get_tree().call_group("disguise_display", "update_disguises", num_disguises)


func _on_timer_timeout():
	reveal()


func collect_briefcase():
	var loot : Node = Node.new()
	loot.set_name("Briefcase")
	add_child(loot)
