extends Node2D

func _on_area_2d_area_entered(_area):
	get_tree().change_scene_to_file("res://scenes/levels/cave-1.tscn")
