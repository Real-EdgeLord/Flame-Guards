extends Control
class_name GameOver

var main_menu_scene : PackedScene = load("uid://d0yqan043d787")


func _on_button_button_down() -> void:
	GameManager.clear_objects()
	var main_menu : MainMenu = main_menu_scene.instantiate()
	GameManager.ui_parent.add_child(main_menu)
	GameManager.change_state(GameManager.GameState.MENU)
	queue_free()
