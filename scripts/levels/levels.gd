extends Node2D

@onready var levels_menu_ui = $LevelsMenuUI

@export var level_name: String = 'level-10'

func _on_cave_exit_level_menu_opened():
	GlobalSignals.level_completed.emit(level_name)
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused

func _on_portal_level_menu_opened():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
