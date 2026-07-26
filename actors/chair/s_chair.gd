extends Node2D
class_name Chair


var damage_audio : Array[AudioStreamWAV] =[
	load("uid://bm5yhycxnu5iu"),
	load("uid://dcjaluoglkd80"),
	load("uid://086tc0r7m3ug"),
]

@export var animation_player: AnimationPlayer

@export var health : float = 100
var location : Vector2 
var is_dead : bool = false

@export var sprit: Sprite2D
@export var static_body_2d: StaticBody2D
@export var collision_shape_2d: CollisionShape2D
@export var audio_streem_player_2d: AudioStreamPlayer2D

signal destory_animation
signal damage_animation

signal destory_animation_complete

func _ready() -> void:
	GameManager.chair = self
	var c1 : Error = damage_animation.connect(_on_damge) as Error 
	if c1 != OK :
		print("error in chair damge function")
	

func _physics_process(_delta: float) -> void:
	location = self.position


func take_damage(damge : float) -> void:
	health -= damge
	if health <= 0 and not is_dead :
		is_dead = true
		destory_animation.emit()
		await destory_animation_complete
		GameManager.game_over()
		destory_chair()
	else :
		damage_animation.emit()
		

func _on_damge() -> void :
	audio_streem_player_2d.stream = damage_audio.get(randi_range(0,2))
	audio_streem_player_2d.play()
	animation_player.play("new_animation")
	await audio_streem_player_2d.finished 
	if animation_player.is_playing() :
		await animation_player.animation_finished
	destory_animation_complete.emit()
	pass 


func destory_chair() -> void :
	queue_free()
