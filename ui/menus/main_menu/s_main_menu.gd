class_name MainMenu extends Control


signal init_completed


var about_menu : PackedScene = preload("uid://b4ffuf0ldkc57")
var settings_menu : PackedScene = preload("uid://nqhx57o27mpx")

func _ready() -> void:
	init_completed.emit()


func _on_bt_start_game_pressed() -> void:
	GameManager.change_state(GameManager.GameState.LOADING)
	SceneManager.show_loading_screen()
	var work_shop_scene : PackedScene = await SceneManager.change_scene("uid://b8jo106lk6luu")
	var work_shop: Node = work_shop_scene.instantiate()
	GameManager.level_parent.add_child(work_shop)
	var player_scene : PackedScene = await SceneManager.change_scene("uid://m7rn1g4g3kfa")
	var player: Player = player_scene.instantiate()
	GameManager.level_parent.add_child(player)
	SceneManager.hide_loading_screen()
	GameManager.change_state(GameManager.GameState.PLAYING)
	queue_free()




func _on_bt_settings_pressed() -> void:
	var settings_menu_scene: SettingsMenu = settings_menu.instantiate()
	GameManager.ui_parent.add_child(settings_menu_scene)
	queue_free()
	




func _on_bt_about_pressed() -> void:
	var about_menu_scene: AboutMenu = about_menu.instantiate()
	GameManager.ui_parent.add_child(about_menu_scene)
	queue_free()



func _on_bt_quit_pressed() -> void:
	GameManager.change_state(GameManager.GameState.QUITING)
	pass
