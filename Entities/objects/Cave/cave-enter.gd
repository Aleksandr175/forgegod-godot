extends Node2D

func _on_area_2d_area_entered(_area):
	SceneManager.change_scene("res://scenes/levels/level-1.tscn")
