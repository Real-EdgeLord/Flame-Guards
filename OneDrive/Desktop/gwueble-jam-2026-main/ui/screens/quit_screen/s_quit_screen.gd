
class_name QuitScreen extends Control


signal quit_screen_full_cover

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	quit_screen_full_cover.emit()
