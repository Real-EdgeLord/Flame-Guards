extends Control
class_name AudioControl


@export var bus_name: StringName
@export var h_slider: HSlider

var bus_indx: int
var current_volume: float
var audio_min: float = 0
var audio_max: float = 1.5
var audio_step: float = 0.01


func _ready() -> void:
	bus_indx = AudioServer.get_bus_index(bus_name)
	if bus_indx == -1:
		return
	h_slider = set_slider_range(h_slider)
	current_volume = AudioServer.get_bus_volume_linear(bus_indx)
	h_slider.value = current_volume
	var c1: Error = h_slider.value_changed.connect(on_drag_started) as Error
	if c1 != OK:
		print("error with volume slider" + bus_name)


func on_drag_started(volume: float) -> void:
	current_volume = volume
	AudioServer.set_bus_volume_linear(bus_indx, volume)


func _on_bt_rest_button_down() -> void:
	on_drag_started(1)
	h_slider.value = 1


func set_slider_range(slider: HSlider) -> HSlider:
	slider.max_value = audio_max
	slider.min_value = audio_min
	slider.step = audio_step
	return slider
