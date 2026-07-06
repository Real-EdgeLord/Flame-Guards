extends Control

@export var spin_speed: float = 180.0

@export var spinner: Control


func _ready() -> void:
	if spinner:
		spinner.pivot_offset = spinner.size / 2.0

func _process(delta: float) -> void:
	if visible and spinner:
		spinner.rotation_degrees = wrapf(
			spinner.rotation_degrees + spin_speed * delta, 0.0, 360.0
		)
