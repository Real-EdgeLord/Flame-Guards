extends Node
class_name Player



@export_group("Node References")
@export var character : PlayerCharacter
@export var player_controller: PlayerController
@export var hud : Hud

var init_location : Vector2
var score : int = 0




func _ready() -> void:
	GameManager.player = self
	character.player_controller = player_controller
	hud.reparent(GameManager.ui_parent)
	var c1 : Error = character.add_to_score.connect(update_score) as Error
	if c1 != OK :
		print("error connecting score counter")



func start_game() -> void :
	character.position = init_location


func update_score(added_score : int ) -> void :
	score += added_score
	hud.update_score_text(score)


func end_game() -> void :
	pass

func destroy() -> void :
	hud.queue_free()
	self. queue_free()
