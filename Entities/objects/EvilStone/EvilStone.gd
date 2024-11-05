extends Node

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.ALTAR_EVIL, 1)
