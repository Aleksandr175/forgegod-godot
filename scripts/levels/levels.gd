extends Node2D

@onready var levels_menu_ui = $LevelsMenuUI

@export var level_name: String = 'level-1'

func _on_cave_exit_level_menu_opened():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
	GameState.complete_level(level_name)

func _on_portal_level_menu_opened():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
