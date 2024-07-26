extends Node2D
class_name PositionScanner

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func is_left_colliding():
	return ray_cast_left.is_colliding()

func is_right_colliding():
	return ray_cast_right.is_colliding()
