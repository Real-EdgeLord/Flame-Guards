extends Node

const button_pressed_stream: AudioStream = preload('uid://dsr7hjvch8e8j')
const button_hover_stream: AudioStream = preload('uid://bvpmy12iqnwjb')

@export var group_name: StringName = &'btnsfx'

func _ready() -> void:
	get_tree().tree_changed.connect(_update)
	
	EventManager.create_event('sound_button_pressed')
	EventManager.link_event('sound_button_pressed', _on_button_pressed)
	
	EventManager.create_event('sound_button_hover')
	EventManager.link_event('sound_button_hover', _on_button_hover)
	
	EventManager.create_event('sound_button_focus')
	EventManager.link_event('sound_button_focus', _on_button_focus)

func _on_button_focus(button: Button) -> void:
	if button.is_hovered(): return
	AudioManager.play_stream(button_hover_stream, -2.0, 'SFX')

func _on_button_hover() -> void:
	AudioManager.play_stream(button_hover_stream, -2.0, 'SFX')

func _on_button_pressed() -> void:
	AudioManager.play_stream(button_pressed_stream, 0.0, 'SFX')

func _update() -> void:
	if not is_inside_tree(): return
	
	var buttons = get_tree().get_nodes_in_group(group_name)
	for button in buttons as Array[Button]:
		EventManager.register_event('sound_button_pressed', button.pressed)
		EventManager.register_event('sound_button_hover', button.mouse_entered)
		EventManager.register_event('sound_button_focus', button.focus_entered, [button])
