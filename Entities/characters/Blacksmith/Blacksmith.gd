extends Node2D

@export var direction: int = 1

func _on_area_2d_2_area_entered(area):
	if area.get_parent() is Player:
		QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.MENTOR, 1)
