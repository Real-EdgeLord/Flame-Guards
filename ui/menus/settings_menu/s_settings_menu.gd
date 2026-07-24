extends Control
class_name SettingsMenu


var is_from_pause : bool = false
var pause_screen : PauseScreen
var main_menu_scene: PackedScene = preload("uid://d0yqan043d787")



func _on_back_button_down() -> void:
	if is_from_pause : 
		pause_screen.visible = true
		queue_free()
	else :
		var main_menu : MainMenu = main_menu_scene.instantiate()
		GameManager.ui_parent.add_child(main_menu)
		queue_free()
