extends Node2D

@onready var shop_ui = $ShopUI

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	
	print(body is Player)
	
	if body is Player:
		shop_ui.visible = !shop_ui.visible


func _on_shop_panel_shop_ui_closed():
	shop_ui.visible = false
