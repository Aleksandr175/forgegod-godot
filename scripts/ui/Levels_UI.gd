extends Control

func _on_village_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/game.tscn")

func _on_level_1_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/level-1.tscn")


func _on_level_2_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/level-2.tscn")


func _on_level_3_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/level-3.tscn")
