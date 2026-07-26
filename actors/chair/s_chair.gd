extends Node2D
class_name Chair


var health : float = 1000
var location : Vector2 

@export var sprit: Sprite2D
@export var static_body_2d: StaticBody2D
@export var collision_shape_2d: CollisionShape2D


signal destory_animation
signal damage_animation

signal destory_animation_complete

func _ready() -> void:
	GameManager.chair = self
	

func _physics_process(_delta: float) -> void:
	location = self.position


func take_damage(damge : float) -> void:
	health -= damge
	if health <= 0 :
		destory_animation.emit()
		await destory_animation_complete
		GameManager.game_over()
		destory_chair()
	else :
		damage_animation.emit()



func destory_chair() -> void :
	queue_free()
