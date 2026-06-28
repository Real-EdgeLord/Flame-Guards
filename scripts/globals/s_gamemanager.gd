extends Node



signal game_state_changed(old_state: GameState, new_state : GameState )


enum GameState {
	STARTING,
	MENU,
	LOADING,
	PLAYING,
	PASED,
	QUITING,
}

var root : Root
var ui_parent : UIParent
var level_parent : LevelParent
var current_state: GameState
var previous_state : GameState 


func _ready() -> void :
	#This lets you run scenes without godot crying about it for testing
	var test_root: Node = get_tree().current_scene
	
	if test_root is Root :
		root = test_root
		level_parent = root.level_parent
		ui_parent = root.ui_parent
		change_state(GameState.STARTING)
		

func change_state(new_state : GameState) -> void :
	if new_state == current_state and new_state != GameState.STARTING :
		return
	previous_state = current_state
	current_state = new_state
	
	game_state_changed.emit(current_state,previous_state)
	_handle_state_change(current_state)

func _handle_state_change(new_state: GameState) -> void:
	match new_state:
		GameState.STARTING:
			_game_starting()
		GameState.PASED:
			_game_paused()
		GameState.MENU:
			_game_menu()
		GameState.LOADING:
			_game_loading()
		GameState.PLAYING:
			_game_playing()
		GameState.QUITING:
			_game_quiting()



func _game_starting() -> void:
	var main_manu_scene : PackedScene = load("uid://d0yqan043d787")
	var main_menu : MainMenu = main_manu_scene.instantiate()
	ui_parent.add_child(main_menu)
	await main_menu.init_completed



func _game_loading() -> void:
	pass



func _game_menu() -> void:
	pass



func _game_paused() -> void:
	pass



func _game_playing() -> void:
	pass



func _game_quiting()-> void:
	var quit_screen_scene : PackedScene = load("uid://dbd1sr2vvylq7")
	var quit_screen : QuitScreen = quit_screen_scene.instantiate()
	ui_parent.add_child(quit_screen)
	await quit_screen.quit_screen_full_cover
	get_tree().quit(0)




func toggle_pause() -> void:
	if current_state == GameState.PLAYING:
		change_state(GameState.PASED)
	elif current_state == GameState.PASED:
		change_state(GameState.PLAYING)
