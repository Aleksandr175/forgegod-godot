extends Node2D

@onready var shop_ui = $ShopUI
@onready var pointer = $Pointer

func _on_area_2d_area_entered(_area):
	pointer.visible = true

func _on_area_2d_area_exited(_area):
	pointer.visible = false

func _on_shop_panel_shop_ui_closed():
	shop_ui.visible = false

func _on_pointer_pointer_pressed():
	shop_ui.visible = true
	QuestManager.update_objective_progress("visit", "dealer", 1)
