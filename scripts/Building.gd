extends Node2D

func _on_door_area_2d_2_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/levels/house_level.tscn")
