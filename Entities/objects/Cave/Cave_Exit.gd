extends Node2D

signal level_menu_opened

func _on_area_2d_area_entered(area):
	var body = area.get_parent()

	if body is Player:
		level_menu_opened.emit()
