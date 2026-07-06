extends Node

signal scene_load_finished

const LOADING_SCREEN: PackedScene = preload("res://ui/screens/loading_screen/sn_loading_screen.tscn")

var _scene_path: String = ""
var _loading: bool = false

var _layer: CanvasLayer
var _loading_screen: Control


func _ready() -> void:
	set_process(false)

	_layer = CanvasLayer.new()
	_layer.layer = 100
	add_child(_layer)

	_loading_screen = LOADING_SCREEN.instantiate()
	_loading_screen.visible = false
	_layer.add_child(_loading_screen)


func change_scene(path: String) -> void:
	if _loading:
		return
	_loading = true
	_scene_path = path

	_loading_screen.visible = true


	var current: Node = get_tree().current_scene
	if current:
		current.queue_free()
		await current.tree_exited

	var err: Error = ResourceLoader.load_threaded_request(_scene_path, "PackedScene")
	if err != OK:
		push_error("Failed to start loading: %s" % _scene_path)
		_finish(null)
		return

	set_process(true)


func _process(_delta: float) -> void:
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(_scene_path)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			pass  # spinner is handled in loading_screen.gd
		ResourceLoader.THREAD_LOAD_LOADED:
			set_process(false)
			var packed: PackedScene = ResourceLoader.load_threaded_get(_scene_path)
			_finish(packed)
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
			push_error("Failed to load scene: %s" % _scene_path)
			_finish(null)


func _finish(packed: PackedScene) -> void:
	if packed:
		var new_scene: Node = packed.instantiate()
		get_tree().root.add_child(new_scene)
		get_tree().current_scene = new_scene

	_loading_screen.visible = false
	_loading = false
	scene_load_finished.emit()
