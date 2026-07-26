extends Node2D
class_name Level

@export var sn_chair: Chair
@export var spawn_posstions: Node2D

@export var spawn_time_min : float = 0.5
@export var spawn_time_max : float = 1

@export var spawn_rate : int = 2

var should_spawn : bool = false



var enemys : Array[PackedScene] = [
	load("uid://cjyclj6q4ouvc"),
	load("uid://dbbb88u7pjtbb"),
	load("uid://cqffxtmh4t4o3")
]

var spawn_timer : Timer

func start_game() -> void :
	should_spawn = true
	spawn_timer = Timer.new()

	self.add_child(spawn_timer)
	var c1 : Error = spawn_timer.timeout.connect(_on_spawn_timer_timeout) as Error
	if c1 != OK :
		print("problem, in level spawning timer")
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void :
	if should_spawn:
		for i : int in spawn_rate :
			spawn_enemy()



func end_game() -> void :
	should_spawn = false



func spawn_enemy() -> void :
	if GameManager.current_state == GameManager.GameState.PLAYING and should_spawn:
		await get_tree().create_timer(randf_range(spawn_time_min,spawn_time_max)).timeout
	var enemy_scene : PackedScene = enemys.get(randi_range(0,2))
	var enemey : BaseEnemy = enemy_scene.instantiate()
	GameManager.level_parent.add_child(enemey)
	var spawn_location_count : int = spawn_posstions.get_child_count()
	var spawn_point : Node2D = spawn_posstions.get_child(randi_range(0,spawn_location_count -1 ))
	enemey.position = spawn_point.position
