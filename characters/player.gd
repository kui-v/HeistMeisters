extends "res://characters/template_character.gd"

const PLAYER_SPRITE : String = "res://assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE : String = "res://assets/GFX/PNG/Tiles/tile_130.png"
const PLAYER_OCCLUDER : String = "res://characters/human_occluder.tres"
const BOX_OCCLUDER : String = "res://characters/box_occluder.tres"
var is_disguised : bool = false


func _physics_process(delta):
	update_movement()
	move_and_slide()


func update_movement():
	look_at(get_global_mouse_position()) # character look at mouse
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		velocity.y = clamp(velocity.y + SPEED, 0, MAX_SPEED) # velocity does not go past max speed or below min
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		velocity.y = clamp(velocity.y - SPEED, -MAX_SPEED, 0)
	else:
		velocity.y = lerp(velocity.y, 0.0, FRICTION) # velocity eases from x to y by speed friction
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x = clamp(velocity.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x = clamp(velocity.x - SPEED, -MAX_SPEED, 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)


func _input(event):
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


func toggle_disguise():
	if is_disguised:
		reveal()
	else:
		disguise()


func reveal():
	$Sprite2D.texture = load(PLAYER_SPRITE)
	is_disguised = false
	collision_layer = 1
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)


func disguise():
	$Sprite2D.texture = load(BOX_SPRITE)
	is_disguised = true
	collision_layer = 16 #currently nothing set here
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
