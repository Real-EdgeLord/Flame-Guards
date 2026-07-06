class_name MainMenu
extends Control

signal init_completed

@onready var _game_manager: GameManagerBase = GameManager

func _ready() -> void:
	init_completed.emit()

func _on_bt_start_game_pressed() -> void:
	SceneManager.change_scene("res://levels/game_play/sn_level_1.tscn")

func _on_bt_settings_pressed() -> void:
	pass # Replace with function body.


func _on_bt_about_pressed() -> void:
	pass # Replace with function body.

func _on_bt_quit_pressed() -> void:
	_game_manager.change_state(GameManagerBase.GameState.QUITING)
