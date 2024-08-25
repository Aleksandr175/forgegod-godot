extends Node2D

@onready var levels_menu_ui = $LevelsMenuUI

func _on_cave_exit_level_menu_opened():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
