extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	QuestManager.update_objective_progress("visit", "library", 1)


func _on_exit_area_2d_area_entered(area):
	SceneManager.change_scene("res://Stages/Levels/Village.tscn")
