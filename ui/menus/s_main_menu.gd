class_name MainMenu extends Control


signal init_completed

func _ready() -> void:
	init_completed.emit()

func _on_bt_start_game_pressed() -> void:
	pass # Replace with function body.


func _on_bt_settings_pressed() -> void:
	pass # Replace with function body.


func _on_bt_about_pressed() -> void:
	pass # Replace with function body.


func _on_bt_quit_pressed() -> void:
	GameManager.change_state(GameManager.GameState.QUITING)
	
