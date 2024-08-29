extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	QuestManager.update_objective_progress("visit", "village", 1)
