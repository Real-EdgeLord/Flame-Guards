extends Control
class_name Hud

@export var score_number: Label
@export var virtual_joystick: VirtualJoystick

var score : int = 0 

func _ready() -> void:
	if not GameManager.show_joystick :
		virtual_joystick.visible = false

func update_score_text(_score : int ) ->void :
	score = _score
	score_number.text = str(score)
	pass
