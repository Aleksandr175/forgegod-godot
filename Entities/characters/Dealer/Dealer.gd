extends Node2D

@onready var shop_ui = $ShopUI

func _on_shop_panel_shop_ui_closed():
	shop_ui.visible = false

func _on_pointer_pointer_pressed():
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.DEALER, 1)
	shop_ui.visible = true


func _on_area_2d_area_exited(_area):
	shop_ui.visible = false
