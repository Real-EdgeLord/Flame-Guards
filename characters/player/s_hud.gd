extends Control
class_name Hud

@export var score_number: Label
@export var virtual_joystick: VirtualJoystick
@export var pause_touch: Button
@export var attack_joy_stick: VirtualJoystick

var score : int = 0

func _ready() -> void:
	if not GameManager.show_joystick :
		pass
		virtual_joystick.visible = false
		pause_touch.visible = false
		attack_joy_stick.visible = false

func update_score_text(_score : int ) ->void :
	score = _score
	score_number.text = str(score)
	pass


func _on_pause_touch_button_down() -> void:
	var ui_event: InputEventAction = InputEventAction.new()
	ui_event.action = "meun"
	ui_event.pressed = true
	Input.parse_input_event(ui_event)
	



func _on_pause_touch_button_up() -> void:
	Input.action_release("meun")
