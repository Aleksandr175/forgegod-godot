extends Node2D

func _on_exit_area_2d_area_entered(area):
	if area.get_parent() is PlayerHouse:
		get_tree().change_scene_to_file("res://scenes/levels/game.tscn")
