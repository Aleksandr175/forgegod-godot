extends Node2D

@onready var player = $Player
@onready var levels_menu_ui = $LevelsMenuUI

@export var level_name: String = 'level-4'

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = player.find_child("Camera2D")
	camera.limit_bottom = 1000000
	print(camera)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cave_exit_level_menu_opened():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
	GameState.complete_level(level_name)
