extends Node
class_name PlayerController


@export_group("Input Actions")
@export var action_left: StringName = &"move_left"
@export var action_right: StringName = &"move_right"
@export var action_up: StringName = &"move_up"
@export var action_down: StringName = &"move_down"
@export var action_menu: StringName = &"meun"

var input_active : bool 

var move_dir : Vector2



func _ready() -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	if ! input_active :
		move_dir = Vector2.ZERO
		return
	move_dir = Input.get_vector(action_left, action_right, action_up, action_down)
	if _event.is_action(action_menu):
		#TODO :
		GameManager.toggle_pause()
		#show pause menu which does not exsist yet
		pass
