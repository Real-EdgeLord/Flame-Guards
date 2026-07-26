extends Node
class_name Player



@export_group("Node References")
@export var character : PlayerCharacter
@export var player_controller: PlayerController
@export var hud : Hud

var init_location : Vector2


func _ready() -> void:
	GameManager.player = self
	character.player_controller = player_controller
	hud.reparent(GameManager.ui_parent)



func start_game() -> void :
	character.position = init_location


func end_game() -> void :
	pass

func destory() -> void :
	hud.queue_free()
	self. queue_free()
