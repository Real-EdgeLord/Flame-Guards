extends Node


signal game_state_changed(old_state: GameState, new_state: GameState )

var pause_screen_scene : PackedScene = preload("uid://bl6gpuwjdi6ib")
var pause_screen : PauseScreen

enum GameState {
	STARTING,
	MENU,
	LOADING,
	PLAYING,
	PASED,
	QUITING,
}

var root: Root
var ui_parent: UIParent
var level_parent: LevelParent
var current_state: GameState
var previous_state: GameState

var character_input : bool = false
var player : Player
var player_controller : PlayerController


func _ready() -> void:
	#This lets you run scenes without godot crying about it for testing
	var test_root: Node = get_tree().current_scene

	if test_root is Root:
		root = test_root
		level_parent = root.level_parent
		ui_parent = root.ui_parent
		change_state(GameState.STARTING)


func change_state(new_state: GameState) -> void:
	if new_state == current_state and new_state != GameState.STARTING:
		return
	previous_state = current_state
	current_state = new_state

	game_state_changed.emit(current_state, previous_state)
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
	var main_manu_scene: PackedScene = load("uid://d0yqan043d787")
	var main_menu: MainMenu = main_manu_scene.instantiate()
	ui_parent.add_child(main_menu)
	await main_menu.init_completed
	GameManager.change_state(GameManager.GameState.MENU)


func _game_loading() -> void:
	if player_controller != null :
		player_controller.input_active = false
	pass


func _game_menu() -> void:
	if player_controller != null :
		player_controller.input_active = false
	pass


func _game_paused() -> void:
	if player_controller != null :
		player_controller.input_active = false
	pause_screen = pause_screen_scene.instantiate()
	ui_parent.add_child(pause_screen)


var chair : Chair

func _game_playing() -> void:
	if player_controller != null :
		player_controller.input_active = true
	var screen_center: Vector2 = get_viewport().get_visible_rect().size / 2.0
	player.init_location = screen_center
	player.start_game()


func game_over() -> void:
	
	
	
	pass



func _game_quiting()-> void:
	var quit_screen_scene: PackedScene = load("uid://dbd1sr2vvylq7")
	var quit_screen: QuitScreen = quit_screen_scene.instantiate()
	ui_parent.add_child(quit_screen)
	await quit_screen.quit_screen_full_cover
	get_tree().quit(0)



func toggle_pause() -> void:
	if current_state == GameState.PLAYING:
		Engine.time_scale = 0
		change_state(GameState.PASED)
	elif current_state == GameState.PASED:
		change_state(GameState.PLAYING)
		Engine.time_scale = 1
		if pause_screen != null :
			pause_screen.queue_free()
