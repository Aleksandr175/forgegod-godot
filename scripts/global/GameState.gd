extends Node

# data can be used only for save/load
var player_scene: String = "res://Stages/Levels/instruction.tscn"  # Default starting scene
var player_inventory: Array = []  # List of inventory items
var quest_progress: Dictionary = {}  # Track quest stages
var level_progress: Dictionary = {}  # Track levels unlocked/completed
var completed_quest_ids: Array = []  # List of IDs of completed quests
var unlocked_recipes: Array = []  # List of IDs of unlocked recipes

#var other_data: Dictionary = {}  # Any additional data
var entry_point: String = ""

var is_loaded = false

var levels = {
	#"village": {"unlocked": true, "completed": false},
	"level-1": {"unlocked": true, "completed": false, "label": "Forest"},
	"level-2": {"unlocked": false, "completed": false, "label": "Iron Cave"},
	"level-3": {"unlocked": false, "completed": false, "label": "Emerald Cave"},
	"level-5": {"unlocked": false, "completed": false, "label": "Dark Cave"},
	"level-4": {"unlocked": false, "completed": false, "label": "Twilightite Cave"},
	"level-6": {"unlocked": false, "completed": false, "label": "Deep Forest"},
	"level-7": {"unlocked": false, "completed": false, "label": "Evil's Seal"},
	# Add more levels as needed
}

var current_level_name = "village"
var level_order = ["level-1", "level-2", "level-3", "level-4", "level-5", "level-6", "level-7"]  # Define the order of levels

func _ready():
	#remove_corrupted_save()
	load_game()
	pass

func complete_level(level_name):
	if level_progress.has(level_name):
		level_progress[level_name]["completed"] = true
		var current_index = level_order.find(level_name)

		if current_index != -1 and current_index + 1 < level_order.size():
			var next_level = level_order[current_index + 1]
			unlock_level(next_level)
		save_game()
	else:
		print("Level name not found in level_progress: ", level_name)

func unlock_level(level_id: String):
	if level_progress.has(level_id):
		if level_progress[level_id]["unlocked"] != true:
			level_progress[level_id]["unlocked"] = true
			levels["unlocked"] = true
			print("Level unlocked: ", level_id)
			GlobalSignals.level_unlocked.emit(level_id)
			save_game()
		else:
			print("Level already unlocked: ", level_id)
	else:
		print("Level ID not found in level_progress: ", level_id, ". Trying to add...")
		level_progress[level_id] = levels[level_id]
		unlock_level(level_id)

func is_level_unlocked(level_id: String) -> bool:
	if level_progress.has(level_id):
		return level_progress[level_id]["unlocked"]
	else:
		print("Level ID not found in level_progress: ", level_id)
		return false
	
func change_scene(scene_path):
	var packed_scene = load(scene_path)
	var new_scene = packed_scene.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

func save_game():
	var save_data = {
		"player_scene": player_scene,
		"player_inventory": player_inventory,
		#"quest_progress": quest_progress,
		"level_progress": level_progress,
		"completed_quest_ids": completed_quest_ids,
		"unlocked_recipes": unlocked_recipes,
		#"other_data": other_data
	}

	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Game saved successfully.")
	else:
		print("Failed to save game.")

func load_game():
	if is_loaded:
		return

	is_loaded = true

	if FileAccess.file_exists("user://save_game.json"):
		var file = FileAccess.open("user://save_game.json", FileAccess.READ)
		if file:
			var save_text = file.get_as_text()
			file.close()

			var data = JSON.parse_string(save_text)
			
			print('---------------------')
			print('saved data: ', data)
			print('---------------------')
			if data is Dictionary:
				player_scene = data.get("player_scene", player_scene)
				player_inventory = data.get("player_inventory", player_inventory)
				#quest_progress = data.get("quest_progress", quest_progress)
				level_progress = data.get("level_progress", level_progress)
				completed_quest_ids = data.get("completed_quest_ids", completed_quest_ids)
				#completed_quest_ids = ["quest_second_chapter_24"]
				unlocked_recipes = data.get("unlocked_recipes", unlocked_recipes)
				#other_data = data.get("other_data", other_data)
				print("Game loaded successfully.")
				GlobalSignals.game_loaded.emit()

				# Apply level_progress to levels
				_apply_level_progress()

				# Defer changing the scene to prevent issues
				call_deferred("_change_to_saved_scene")
			else:
				print("Save file is corrupted. Starting a new game.")
		else:
			print("Failed to load game.")
	else:
		print("No save file found. Starting a new game.")
		start_new_game()

func _apply_level_progress():
	for level_id in level_progress.keys():
		if levels.has(level_id):
			# Here, you can apply any additional logic if needed
			pass
		else:
			print("Level ID not found in levels: ", level_id)

func _change_to_saved_scene():
	SceneManager.change_scene(player_scene)

func start_new_game():
	# started location
	player_scene = "res://Stages/Levels/instruction.tscn"

	player_inventory = []
	quest_progress = {}
	completed_quest_ids = []
	unlocked_recipes = [Inventory.inventory_dictionary["spearWooden"]["id"]]
	#other_data = {}
	
	# Initialize level_progress
	level_progress = {}
	for level_id in levels.keys():
		level_progress[level_id] = {
			"unlocked": false,
			"completed": false
		}
	# Unlock the first level
	level_progress["level-1"]["unlocked"] = true

	save_game()
	SceneManager.change_scene(player_scene)
	GlobalSignals.new_game_started.emit()

func is_game_started() -> bool:
	return FileAccess.file_exists("user://save_game.json")

func remove_corrupted_save():
	var save_path = "save_game.json"  # Only the file name
	var dir = DirAccess.open("user://")
	if dir:
		if dir.file_exists(save_path):
			var error = dir.remove(save_path)
			if error == OK:
				print("Corrupted save file removed successfully.")
			else:
				print("Failed to remove the corrupted save file. Error code: %s" % str(error))
		else:
			print("Save file not found.")
	else:
		print("Failed to open user:// directory.")

func save_quests(completed_quest_ids_data) -> void:
	completed_quest_ids = completed_quest_ids_data
	save_game()

func save_scene(scene_path: String) -> void:
	player_scene = scene_path
	save_game()
