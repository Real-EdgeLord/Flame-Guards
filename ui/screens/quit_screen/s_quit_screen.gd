
class_name QuitScreen extends Control


signal quit_screen_full_cover

func _ready() -> void:
	var timer : Timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	timer.wait_time = 1.0
	self.add_child(timer)
	await timer.timeout
	quit_screen_full_cover.emit()
