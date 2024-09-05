extends Node2D

func _on_pointer_pointer_pressed():
	get_tree().change_scene_to_file("res://Stages/Levels/house_level.tscn")
