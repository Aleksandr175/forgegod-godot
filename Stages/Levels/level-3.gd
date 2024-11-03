extends Node2D

@onready var player = $Player
@onready var levels_menu_ui = $LevelsMenuUI

@export var level_name: String = 'level-3'

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = player.find_child("Camera2D")
	camera.limit_bottom = 1000000
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, level_name, 1)

func _on_cave_exit_level_menu_opened():
	GlobalSignals.level_completed.emit(level_name)
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
