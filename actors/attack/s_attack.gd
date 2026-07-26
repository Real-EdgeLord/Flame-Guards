extends Node2D
class_name Attack


@export var damage : float 


func destroy() -> void :
	queue_free()
