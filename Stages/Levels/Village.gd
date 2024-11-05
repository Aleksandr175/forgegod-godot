extends Node2D

@onready var levels_menu_ui = $LevelsMenuUI

# Called when the node enters the scene tree for the first time.
func _ready():
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, Enums.QuestTargetObjects.VILLAGE, 1)

	var player = get_node_or_null("Player")
	if player == null:
		print("Player node not found in the scene.")
		return

	if GameState.entry_point != "":
		var entry_point_node = get_node_or_null("EntryPoints/" + GameState.entry_point)
		if entry_point_node:
			player.global_position = entry_point_node.global_position
			print("Player positioned at entry point:", GameState.entry_point)
		else:
			print("Entry point not found:", GameState.entry_point)
	else:
		print("No entry point specified.")

func _on_portal_to_cave_portal_entered():
	levels_menu_ui.visible = !levels_menu_ui.visible
	get_tree().paused = !get_tree().paused
