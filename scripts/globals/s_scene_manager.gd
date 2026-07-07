extends Node

signal scene_load_finished

const LOADING_SCREEN: PackedScene = preload("uid://cgcx532nhhtg8")

var _scene_path: String = ""
var _loading: bool = false

var _layer: CanvasLayer
var _loading_screen: Control

var _loaded_scene : PackedScene

func _ready() -> void:
	set_process(false)

	_layer = CanvasLayer.new()
	_layer.layer = 100
	add_child(_layer)

	_loading_screen = LOADING_SCREEN.instantiate()
	_loading_screen.visible = false
	_layer.add_child(_loading_screen)


func change_scene(path: String) -> PackedScene:
	if _loading:
		return null
	_loading = true
	_scene_path = path

	_loading_screen.visible = true


	#var current: Node = get_tree().current_scene
	#if current:
		#current.queue_free()
		#await current.tree_exited

	var err: Error = ResourceLoader.load_threaded_request(_scene_path, "PackedScene")
	if err != OK:
		push_error("Failed to start loading: %s" % _scene_path)
		_finish(null)
		return null

	set_process(true)
	await scene_load_finished
	return _loaded_scene


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
		_loaded_scene = packed
	_loading_screen.visible = false
	_loading = false
	scene_load_finished.emit()
	set_process(false)
