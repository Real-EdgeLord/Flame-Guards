extends Node
class_name PlayerController

@export var player: Player


@export_group("Input Actions")
@export var action_left: StringName = &"move_left"
@export var action_right: StringName = &"move_right"
@export var action_up: StringName = &"move_up"
@export var action_down: StringName = &"move_down"
@export var action_menu: StringName = &"menu"
@export var action_attack: StringName = &"attack"
@export var action_attack_left: StringName = &"attack_left"
@export var action_attack_right: StringName= &"attack_right"
@export var action_attack_up: StringName= &"attack_up"
@export var action_attack_down: StringName= &"attack_down"

var input_active : bool 

var move_dir : Vector2
var attack_dir : Vector2
var attack : bool = false

var last_mouse_possition : Vector2

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	_unhandled_input(event)

func _unhandled_input(_event: InputEvent) -> void:
	if !input_active:
		move_dir = Vector2.ZERO
		attack_dir = Vector2.ZERO
		attack = false
		return
	attack_dir = Input.get_vector(action_attack_left, action_attack_right, action_attack_up, action_attack_down)
	move_dir = Input.get_vector(action_left, action_right, action_up, action_down)
	if _event.is_action(action_menu):
		GameManager.toggle_pause()
	if _event.is_action(action_attack) or _event.is_action(action_attack_up) or _event.is_action(action_attack_left):
		if _event.is_pressed() :
			attack = true
		else :
			attack = false
			attack_dir = Vector2.ZERO
	
	if _event is InputEventMouseMotion :
		var mouse_motion : InputEventMouseMotion = _event
		last_mouse_possition = mouse_motion.position
		if attack :
			attack_dir = ( mouse_motion.position - player.character.position).normalized()
		return
