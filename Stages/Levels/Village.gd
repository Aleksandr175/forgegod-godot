extends Node2D

@onready var levels_menu_ui = $LevelsMenuUI

# Called when the node enters the scene tree for the first time.
func _ready():
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, "village", 1)


func _on_portal_to_cave_portal_entered():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
