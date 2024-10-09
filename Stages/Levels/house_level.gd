extends Node2D

@onready var inventory_ui = $InventoryUI

func _ready():
	QuestManager.update_objective_progress("visit", "house", 1)

func _on_exit_area_2d_area_entered(area):
	if area.get_parent() is PlayerHouse:
		SceneManager.change_scene("res://Stages/Levels/Village.tscn")

func _on_inventory_panel_inventory_closed():
	inventory_ui.visible = false
	get_tree().paused = false

func _on_furnace_inventory_opened():
	inventory_ui.visible = true
	get_tree().paused = true
