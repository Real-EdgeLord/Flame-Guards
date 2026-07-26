extends CharacterBody2D
class_name BaseEnemy

@export var movement_speed: float = 50
@export var navigation_agent: NavigationAgent2D 
var movement_delta: float
@export var sprite_2d: Sprite2D


@export var health : float = 10
@export var damage : float = 5
@export var score : int = 10
var is_dead : bool = false

signal destroy_animation
signal damage_animation

#signal destroy_animation_complete


func _ready() -> void:
	var c1 : Error = navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed)) as Error
	if c1 != OK :
		print("error in enmey conncect")


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

func set_movement_target(movement_target: Vector2) -> void :
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta : float) -> void:
	if GameManager.current_state == GameManager.GameState.PLAYING and GameManager.chair != null :
		set_movement_target(GameManager.chair.location)
	# Do not query when the map has never synchronized and is empty.
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	if velocity.x < 0 :
		sprite_2d.flip_h = true
	var c1 : bool =  move_and_slide() 
	if c1 == true : 
		check_collsion()



func check_collsion() -> void :
	for i : int in get_slide_collision_count() :
		var collsion : KinematicCollision2D = get_slide_collision(i)
		var colider : Node = collsion.get_collider()
		var colider_parent : Node = colider.owner
		#if colider_parent is Player : 
			#print("collided with palyer")
		if colider_parent is Chair :
			var chair : Chair = colider_parent
			damage_chair(chair)
		if colider_parent is Attack :
			var attack : Attack = colider_parent
			take_damage(attack.damage)
			attack.destroy()
			print("collided with fire")


func take_damage(_damage : float) -> void:
	health -= _damage
	if health <= 0 and not is_dead:
		is_dead = true
		destroy_animation.emit()
		#await destroy_animation_complete
		destroy()
	else :
		damage_animation.emit()

func damage_chair(chair : Chair) -> void :
	if not is_dead :
		is_dead = true
		chair.take_damage(damage)
		destroy_animation.emit()
		#await destroy_animation_complete
		destroy()
		pass


func destroy() -> void :
	self.queue_free()
	
	pass
