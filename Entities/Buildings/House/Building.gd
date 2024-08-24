extends Node2D

@onready var pointer = $Pointer

func _ready():
	pointer.visible = false

func _on_door_area_2d_2_body_entered(_body):
	print('pointer visible', _body)
	pointer.visible = true

func _on_door_area_2d_2_body_exited(body):
	pointer.visible = false

func _on_pointer_pointer_pressed():
	get_tree().change_scene_to_file("res://Stages/Levels/house_level.tscn")
	pass # Replace with function body.
