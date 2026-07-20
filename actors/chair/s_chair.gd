extends Node2D
class_name Chair


@export var back: Sprite2D
@export var seat: Sprite2D
@export var legs: Sprite2D
@export var color: Color

func set_back(back_piece : ChairPiece) -> void :
	
	pass


func set_seat(seat_piece : ChairPiece) -> void :
	
	pass


func set_legs(leg_piece : ChairPiece) -> void :
	
	pass


func destory_chair() -> void :
	queue_free()
