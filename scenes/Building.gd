extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_door_area_2d_2_body_entered(body):
	print("door")
	pass # Replace with function body.


func _on_roof_area_2d_body_entered(body):
	print("roof")
	pass # Replace with function body.
