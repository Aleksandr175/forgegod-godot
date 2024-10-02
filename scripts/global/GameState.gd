extends Node

var levels = {
	#"village": {"unlocked": true, "completed": false},
	"level-1": {"unlocked": true, "completed": false},
	"level-2": {"unlocked": false, "completed": false},
	"level-3": {"unlocked": false, "completed": false},
	"level-4": {"unlocked": false, "completed": false},
	# Add more levels as needed
}

var current_level_name = "village"
var level_order = ["level-1", "level-2", "level-3", "level-4"]  # Define the order of levels

func _ready():
	#load_game()
	pass

func complete_level(level_name):
	levels[level_name]["completed"] = true
	var current_index = level_order.find(level_name)

	if current_index != -1 and current_index + 1 < level_order.size():
		var next_level = level_order[current_index + 1]
		levels[next_level]["unlocked"] = true
		print(next_level + " has been unlocked!")

	#save_game()
	
func change_scene(scene_path):
	var packed_scene = load(scene_path)
	var new_scene = packed_scene.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
