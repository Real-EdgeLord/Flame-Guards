extends Node
class_name PlayerController


@export_group("Input Actions")
@export var action_left: StringName = &"move_left"
@export var action_right: StringName = &"move_right"
@export var action_up: StringName = &"move_up"
@export var action_down: StringName = &"move_down"


var move_dir : Vector2



func _unhandled_input(_event: InputEvent) -> void:
	move_dir = Input.get_vector(action_left, action_right, action_up, action_down)
	
