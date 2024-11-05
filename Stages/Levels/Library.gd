extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.LIBRARY, 1)


func _on_exit_area_2d_area_entered(area):
	SceneManager.change_scene("res://Stages/Levels/Village.tscn", "from_library")

func _on_altar_area_2d_area_entered(area):
	var body = area.get_parent()

	if body is Player or body is PlayerHouse:
		QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.ALTAR, 1)
