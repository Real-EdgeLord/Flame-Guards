extends Label

@export var print_fps_or_frame_time: bool = true
@export  var print_fps_delay: float  = 0.2

var fps: float = 0.0
var frame_time: float = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
var print_time: float = 0


# Called when the node enters the scene tree for the first time.
var selfy: Label = self


func _ready() -> void:
	selfy = self
	pass # Replace with function body.


func _process(delta: float) -> void:
	print_time += delta
	if print_time >= print_fps_delay:
		if print_fps_or_frame_time:
			fps = 1.0 / delta
			var engine_fps: float = Engine.get_frames_per_second()
			selfy.text = "FPS : " +  str(engine_fps)

			#var roundedDelta = snappedf(delta*1000, 0.01)
			#print("Frame Time ms: ", roundedDelta)
		else:
			frame_time += delta
			selfy.text = "Frame Time ms: " + str(snappedf(delta * 1000, 0.01))
			frame_time = 0.0

			#var roundedDelta = snappedf(delta*1000, 0.01)
			#print("Frame Time ms: ", roundedDelta)
		print_time = 0.0
