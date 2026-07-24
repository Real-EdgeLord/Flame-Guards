extends Control
class_name PauseScreen


func _on_bt_play_button_down() -> void:
	GameManager.toggle_pause()
	queue_free()


func _on_bt_settings_button_down() -> void:
	var settings_menu_scene : PackedScene = load("uid://nqhx57o27mpx")
	var settings_menu : SettingsMenu = settings_menu_scene.instantiate()
	settings_menu.is_from_pause = true
	settings_menu.pause_screen = self
	self.visible = false
	GameManager.ui_parent.add_child(settings_menu)


func _on_bt_main_menu_button_down() -> void:
	GameManager.change_state(GameManager.GameState.MENU)
	var main_menu_scene : PackedScene = load("uid://d0yqan043d787")
	var main_menu : MainMenu = main_menu_scene.instantiate()
	for child : Node in GameManager.level_parent.get_children() :
		child.queue_free()
	for child  : Control in GameManager.ui_parent.get_children() :
		if child != self :
			child.queue_free()
	GameManager.ui_parent.add_child(main_menu)
	queue_free()


func _on_bt_quit_button_down() -> void:
	GameManager.toggle_pause()
	GameManager.change_state(GameManager.GameState.QUITING)
