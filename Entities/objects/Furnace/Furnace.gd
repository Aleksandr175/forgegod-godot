extends Node2D

signal inventory_opened

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	
	if body is PlayerHouse:
		inventory_opened.emit()
