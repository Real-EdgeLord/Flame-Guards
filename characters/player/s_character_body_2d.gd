extends CharacterBody2D
class_name PlayerCharacter

@export_group("Movement")
@export var move_speed: float = 100.0
@export var chair_damge: float = 5
@export var boost_peak : int = 300
@export var boost_timer_seconds : float = 10
@export var can_shoot_while_boost : bool = false
var current_boost : int
var is_boost_locked : bool = true
var can_shoot : bool = false

@export_group("Node References")
@export var sprite: Sprite2D
@export var animation_tree: AnimationTree
@export var audio_stream_player_2d: AudioStreamPlayer2D
@export var area_2d: Area2D




@export_group("Animation States")
@export var idle_state: StringName = &"Idle"
@export var walk_state: StringName = &"Walk"
@export var idle_blend_param: StringName = &"parameters/Idle/blend_position"
@export var walk_blend_param: StringName = &"parameters/Walk/blend_position"


var attack_audio : Array[AudioStreamWAV] =[
	load("uid://eg5m8osjcno6"),
	load("uid://cyjgmm05ai115"),
	load("uid://coaau4bj8xb4o"),
	load("uid://c7khkssmgs4f1"),
]

var _playback: AnimationNodeStateMachinePlayback
var _last_direction: Vector2 = Vector2.DOWN


var player_controller: PlayerController

signal add_to_score (score :int )

func _ready() -> void:
	if animation_tree == null:
		return
	animation_tree.active = true
	var playback_variant: Variant = animation_tree.get(&"parameters/playback")
	if playback_variant is AnimationNodeStateMachinePlayback:
		_playback = playback_variant
	area_2d.visible = false





func _physics_process(_delta: float) -> void:
	var move_dir : Vector2 = player_controller.move_dir
	velocity = move_dir * move_speed
	var _collided: bool = move_and_slide()
	if _collided == true:
		check_collsion()

	if player_controller.attack :
		if can_shoot :
			var attack_direction : Vector2 = player_controller.attack_dir
			if attack_direction.is_zero_approx() :
				return
			var angle : float = attack_direction.angle() 
			area_2d.rotation = angle
			area_2d.visible = true
			area_2d.monitoring = true
		else :
			area_2d.visible = false
			area_2d.monitoring = false
	else :
		area_2d.visible = false
		area_2d.monitoring = false
	
	_update_animation(move_dir)





func check_collsion() -> void :
	for i : int in get_slide_collision_count() :
		var collsion : KinematicCollision2D = get_slide_collision(i)
		var colider : Node = collsion.get_collider()
		var colider_parent : Node = colider.owner
		if colider_parent is Chair :
			var chair : Chair = colider_parent
			damge_chair(chair)
		if colider is BaseEnemy :
			var _enemy : BaseEnemy = colider
			collide_with_enemy(_enemy)



func collide_with_enemy(enemy : BaseEnemy) -> void :
	if enemy != null :
		audio_stream_player_2d.stream = attack_audio.get(randi_range(0,attack_audio.size()-1))
		audio_stream_player_2d.play()
		enemy.take_damage(100)
		add_to_score.emit(enemy.score)
		if is_boost_locked :
			current_boost += enemy.score
			if current_boost >= boost_peak :
				unlock_boost()

func unlock_boost() -> void :

	can_shoot = true
	is_boost_locked = false
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.start(boost_timer_seconds)
	move_speed *= 2
	sprite.self_modulate = Color(0.0, 1.418, 7.417)
	
	await timer.timeout
	
	
	lock_boost()

func lock_boost() -> void:
	can_shoot = false
	move_speed /= 2
	sprite.self_modulate = Color(1,1,1,1)
	is_boost_locked = true
	current_boost = 0 



func damge_chair(chair : Chair) -> void :
	chair.take_damage(chair_damge)
	
	pass


func _update_animation(input_dir: Vector2) -> void:
	if _playback == null or animation_tree == null:
		return
	if input_dir == Vector2.ZERO:
		animation_tree.set(idle_blend_param, _last_direction)
		_playback.travel(idle_state)
		return
	_last_direction = input_dir
	if sprite != null and not is_zero_approx(input_dir.x):
		sprite.flip_h = input_dir.x > 0.0
	animation_tree.set(walk_blend_param, input_dir)
	_playback.travel(walk_state)



func _on_area_2d_body_entered(body: Node2D) -> void:
	var colider : Node = body
	var colider_parent : Node = colider.owner
	if colider_parent is Chair :
		var chair : Chair = colider_parent
		damge_chair(chair)
	if colider is BaseEnemy :
		var _enemy : BaseEnemy = colider
		collide_with_enemy(_enemy)
