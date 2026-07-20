extends CharacterBody2D
class_name SPlayerController

@export_group("Movement")
@export var move_speed: float = 100.0

@export_group("Input Actions")
@export var action_left: StringName = &"move_left"
@export var action_right: StringName = &"move_right"
@export var action_up: StringName = &"move_up"
@export var action_down: StringName = &"move_down"

@export_group("Node References")
@export var sprite: Sprite2D
@export var animation_tree: AnimationTree

@export_group("Animation States")
@export var idle_state: StringName = &"Idle"
@export var walk_state: StringName = &"Walk"
@export var idle_blend_param: StringName = &"parameters/Idle/blend_position"
@export var walk_blend_param: StringName = &"parameters/Walk/blend_position"

var _playback: AnimationNodeStateMachinePlayback
var _last_direction: Vector2 = Vector2.DOWN


func _ready() -> void:
	if animation_tree == null:
		return
	animation_tree.active = true
	var playback_variant: Variant = animation_tree.get(&"parameters/playback")
	if playback_variant is AnimationNodeStateMachinePlayback:
		_playback = playback_variant


func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(action_left, action_right, action_up, action_down)
	velocity = input_dir * move_speed
	var _collided: bool = move_and_slide()
	_update_animation(input_dir)


func _update_animation(input_dir: Vector2) -> void:
	if _playback == null or animation_tree == null:
		return
	if input_dir == Vector2.ZERO:
		animation_tree.set(idle_blend_param, _last_direction)
		_playback.travel(idle_state)
		return
	_last_direction = input_dir
	if sprite != null and not is_zero_approx(input_dir.x):
		sprite.flip_h = input_dir.x < 0.0
	animation_tree.set(walk_blend_param, input_dir)
	_playback.travel(walk_state)
