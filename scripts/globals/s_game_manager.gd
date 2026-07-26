extends Node


signal game_state_changed(old_state: GameState, new_state: GameState )

var pause_screen_scene : PackedScene = preload("uid://bl6gpuwjdi6ib")
var pause_screen : PauseScreen
var show_joystick : bool = false

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
	if OS.has_feature("mobile"):
		show_joystick = true 

	var main_manu_scene: PackedScene = load("uid://d0yqan043d787")
	var main_menu: MainMenu = main_manu_scene.instantiate()
	ui_parent.add_child(main_menu)
	await main_menu.init_completed
	GameManager.change_state(GameManager.GameState.MENU)


func _game_loading() -> void:
	if player!= null :
		player.player_controller.input_active = false
	pass


func _game_menu() -> void:
	if player != null :
		player.player_controller.input_active = false
	pass


func _game_paused() -> void:
	if player != null :
		player.player_controller.input_active = false
	pause_screen = pause_screen_scene.instantiate()
	ui_parent.add_child(pause_screen)


var chair : Chair
var player : Player
var current_level : Level
var game_over_scene : PackedScene = load("uid://dqu1m1103qw7j")



func _game_playing() -> void:
	player.init_location = current_level.player_spawner.position
	if player != null :
		player.player_controller.input_active = true

	
	player.start_game()
	current_level.start_game()






func game_over() -> void:
	var score : int = player.score
	player.end_game()
	current_level.end_game()
	player.player_controller.input_active = false
	var _game_over : GameOver = game_over_scene.instantiate()
	_game_over.score = score
	_game_over.update_score()
	ui_parent.add_child(_game_over)
	


func clear_objects() -> void :
	if chair != null :
		chair.destroy_chair()
	if player != null :
		player.destroy()
	for child : Node in level_parent.get_children() :
		child.queue_free()
	


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
