extends Node2D

@onready var inventory_ui = $InventoryUI

func _ready():
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.HOUSE, 1)

func _on_exit_area_2d_area_entered(area):
	if area.get_parent() is PlayerHouse:
		SceneManager.change_scene("res://Stages/Levels/Village.tscn", "from_house")
