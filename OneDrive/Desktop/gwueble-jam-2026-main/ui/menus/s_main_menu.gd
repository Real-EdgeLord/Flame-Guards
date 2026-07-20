class_name MainMenu extends Control


signal init_completed


func _ready() -> void:
	init_completed.emit()

func _on_bt_start_game_pressed() -> void:
	var loaded_sceen : PackedScene = await SceneManager.change_scene("res://levels/game_play/sn_level_1.tscn")
	var new_scene: Node = loaded_sceen.instantiate()
	GameManager.level_parent.add_child(new_scene)
	queue_free()
	#get_tree().root.add_child(new_scene)
	#get_tree().current_scene = new_scene

func _on_bt_settings_pressed() -> void:
	pass # Replace with function body.


func _on_bt_about_pressed() -> void:
	pass # Replace with function body.

func _on_bt_quit_pressed() -> void:
	GameManager.change_state(GameManager.GameState.QUITING)
	pass
