extends CharacterBody2D
class_name Base_enemy

var hleath : int 
var speed : int 

var target : Vector2

@export var collision_shape_2d: CollisionShape2D
@export var navigation_agent_2d: NavigationAgent2D

func ready() -> void :
	target = Vector2(320,120)
	update_target_location(target)


func _physics_process(delta: float) -> void:
	look_at(target)
	if position.distance_to(target) > 0.5:
		var curloc = global_transform.origin
		var nextloc = navigation_agent_2d.get_next_path_position()
		var new_speed = (nextloc - curloc ).normalized *speed 
		velocity = new_speed
		move_and_slide()
	pass


func update_target_location(_target : Vector2) -> void :
	navigation_agent_2d.set_target_position(_target)
	
	
