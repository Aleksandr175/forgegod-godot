extends Node2D

@onready var inventory_ui = $InventoryUI

func _on_exit_area_2d_area_entered(area):
	if area.get_parent() is PlayerHouse:
		get_tree().change_scene_to_file("res://Stages/Levels/game.tscn")

func _on_inventory_panel_inventory_closed():
	inventory_ui.visible = !inventory_ui.visible
	get_tree().paused = !get_tree().paused

func _on_furnace_inventory_opened():
	inventory_ui.visible = !inventory_ui.visible
	get_tree().paused = !get_tree().paused