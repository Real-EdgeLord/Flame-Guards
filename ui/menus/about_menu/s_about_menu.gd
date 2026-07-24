extends Control
class_name AboutMenu


var main_menu_scene: PackedScene = preload("uid://d0yqan043d787")


func _on_back_button_down() -> void:
	var main_menu : MainMenu = main_menu_scene.instantiate()
	GameManager.ui_parent.add_child(main_menu)
	queue_free()
