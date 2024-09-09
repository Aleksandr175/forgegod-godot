extends Node

var experience = 10

enum QuestStatus {
	available,
	started,
	in_progress,
	finished
}

signal update_quest_ui

@onready var quest_log_ui: Control = %QuestUI  # Reference to the UI element for the quest log
var active_quests: Array = []
var completed_quests: Array = []
var quest_database = {
	"quest_10": {
		"quest_id": "quest_10",
		"title": "Need some money",
		"description": "Collect 5 coins.",
		"objectives": [{
			"description": "Collect 5 coins",
			"type": "collect",
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 3
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 50
			},
			{
				"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
				"qty": 10
			}],
			"experience": 10
		},
		"prerequisites": [],
		"next_quests": ["quest_20"],
		"completion_actions": [{
			"type": "open_portal",
			"path_node": "/root/Instruction/Portal", 
			"name": "Portal"
		}],
		"dialog_data": [
			{"character": "player", "text": "Oh, right, I have no time..."},
			{"character": "player", "text": "But I need collect some money."},
		]
	},
	"quest_20": {
		"quest_id": "quest_20",
		"title": "Visit Village",
		"description": "Visit Village Visit Blacksmith House Visit Blacksmith House Visit Blacksmith House.",
		"objectives": [{
			"type": "visit",
			"item_id": "village",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_30"],
		"dialog_data": [
			{"character": "player", "text": "Good! Portal opened!"},
			{"character": "player", "text": "Let's go to village. I have some deals there."},
		]
	},
	"quest_30": {
		"quest_id": "quest_30",
		"title": "Go to Home",
		"description": "Go back to home.",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
			"qty": 2
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_40"],
		"dialog_data": [
			{"character": "player", "text": "Oh, I forgot to turn off iron in the house!"},
			{"character": "player", "text": "Or no? Let's check it."},
		]
	},
	"quest_40": {
		"quest_id": "quest_40",
		"title": "Go to Forest",
		"description": "Go to Forest.",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_41"],
		"dialog_data": [
			{"character": "player", "text": "Hm, I turned off the iron!"},
			{"character": "player", "text": "But I forgot to collect woods for crafting."},
			{"character": "player", "text": "Hurry, I need to do it before sunset."},
		]
	},
	"quest_41": {
		"quest_id": "quest_41",
		"title": "Advanced Blacksmithing",
		"description": "Craft an Iron Sword.",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_50"],
		"dialog_data": [
			{"character": "player", "text": "Good! Portal opened!"},
			{"character": "player", "text": "Let's go to village. I have some deals there."},
		]
	},
	"quest_50": {
		"quest_id": "quest_50",
		"title": "Visit Village",
		"description": "Visit Village Visit Blacksmith House Visit Blacksmith House Visit Blacksmith House.",
		"objectives": [{
			"type": "visit",
			"item_id": "village",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_5"]
	},

	"quest_5": {
		"quest_id": "quest_5",
		"title": "Visit Blacksmith House",
		"description": "Visit Blacksmith House",
		"objectives": [{
			"type": "visit",
			"item_id": "house",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_6"]
	},
	"quest_6": {
		"quest_id": "quest_6",
		"title": "Visit Dealer",
		"description": "Visit Dealer in Village",
		"objectives": [{
			"type": "visit",
			"item_id": "dealer",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 999
			}],
			"experience": 500
		},
		"prerequisites": [],
		"next_quests": ["quest_7"]
	},
	"quest_7": {
		"quest_id": "quest_7",
		"title": "Buy Wood",
		"description": "Visit Dealer and buy Wood",
		"objectives": [{
			"type": "buy",
			"item_id": Inventory.inventory_dictionary["wood"]["id"],
			"qty": 3
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 999
			}],
			"experience": 500
		},
		"prerequisites": [],
		"next_quests": ["quest_8"]
	},
	"quest_8": {
		"quest_id": "quest_8",
		"title": "Serve Customers",
		"description": "Sell goods to customers",
		"objectives": [{
			"type": "sell",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 9
			}],
			"experience": 500
		},
		"prerequisites": [],
		"next_quests": ["quest_9"]
	},
	"quest_9": {
		"quest_id": "quest_9",
		"title": "Help King",
		"description": "Sell goods to king",
		"objectives": [{
			"type": "king",
			"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
			"qty": 5
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 9
			}],
			"experience": 500
		},
		"prerequisites": [],
		"next_quests": ["quest_11"]
	},
	"quest_11": {
		"quest_id": "quest_11",
		"title": "Serve Customers",
		"description": "Sell goods to customers",
		"objectives": [{
			"type": "sell",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 9
			}],
			"experience": 500
		},
		"prerequisites": [],
		"next_quests": ["quest_12"]
	},
}

func _ready():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", _initialize_ui)
	timer.start()

func _initialize_ui():
	start_quest('quest_10')

func start_quest(quest_id: String):
	var quest_data = quest_database[quest_id]
	
	if quest_data != null:
		# Check if prerequisites are completed
		#for prereq in quest_data["prerequisites"]:
		#	if !completed_quests.has(prereq):
		#		print("Cannot start quest: ", quest_id, ". Prerequisite quest not completed: ", prereq)
		#		return
		
		if quest_data.has("dialog_data"):
			GlobalSignals.start_dialog.emit(quest_data["dialog_data"])
		
		# If all prerequisites are completed, start the quest
		var new_quest = Quest.new()
		new_quest.title = quest_data["title"]
		new_quest.description = quest_data["description"]
		new_quest.rewards = quest_data["rewards"]
		new_quest.status = "In Progress"
		new_quest.quest_id = quest_id
		
		for objective_data in quest_data["objectives"]:
			var objective = Objective.new()
			objective.description = objective_data["description"] if objective_data.has("description") else ""
			objective.target_qty = objective_data["qty"] if objective_data.has("qty") else 0
			objective.item_id = str(objective_data["item_id"]) if objective_data.has("item_id") else "0"
			objective.type = objective_data.type

			new_quest.objectives.append(objective)
		
		active_quests.append(new_quest)
		print("Quest started: ", new_quest.title, " - ", new_quest.quest_id)
		update_quest()

func check_objectives(quest: Quest) -> bool:
	for objective in quest.objectives:
		if not objective.is_completed():
			return false
	return true
	
func distribute_rewards(rewards: Dictionary):
	# Handle giving the player their rewards, e.g., adding items to inventory
	for key in rewards.keys():
		if key == "goods":
			# TODO: add rewards
			for item in rewards["goods"]:
				# Add the new item to the inventory
				Inventory.add_item(item["item_id"], int(item["qty"]))

		#if key == "experience":
			# TODO: add experience

		# Add logic to give the player their reward
		#print("Received reward: ", key, "x", rewards[key])

func complete_quest(quest: Quest):
	if quest.status == "In Progress" and check_objectives(quest):
		quest.status = "Completed"
		distribute_rewards(quest.rewards)
		active_quests.erase(quest)
		completed_quests.append(quest)
		print("Quest completed: ", quest.title, quest.quest_id)
		
		# Handle post-completion actions
		process_completion_actions(quest)

		# Start next quests
		for next_quest_id in quest_database[quest.quest_id]["next_quests"]:
			start_quest(next_quest_id)

func update_quest():
	update_quest_ui.emit(active_quests)

func update_objective_progress(type: String, item_id: String, qty: int):
	print('type ', type, 'item_id ', item_id, 'qty ', qty)
	for quest in active_quests:
		for objective in quest.objectives:
			var target_item_id = str(objective.item_id);
			
			if type == "collect" and objective.type == "collect" and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == "visit" and objective.type == "visit" and target_item_id == item_id:
				do_progress(objective, qty, quest)

			if type == "craft" and objective.type == "craft" and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)
				
			if type == "buy" and objective.type == "buy" and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == "sell" and objective.type == "sell":
				do_progress(objective, qty, quest)

			if type == "king" and objective.type == "king":
				print('ffffffff', objective, qty, quest)
				do_progress(objective, qty, quest)

func do_progress(objective, qty, quest):
	objective.progress(qty)
	update_quest()
	if objective.is_completed():
		#print("Objective completed: ", objective.description)
		complete_quest(quest)
	emit_signal("quest_updated", quest)

func process_completion_actions(quest: Quest):
	var quest_data = quest_database[quest.quest_id]
	if quest_data.has("completion_actions"):
		for action in quest_data["completion_actions"]:
			match action["type"]:
				"open_portal":
					open_portal(action["path_node"])
				_:
					print("Unknown action type: ", action["type"])

func open_portal(portal_node_path: String):
	#print_node_tree(get_tree().root)
	
	#print(get_node('/root/Instruction/Portal'))
	
	var portal = get_node(portal_node_path)
	print('portal name ', portal_node_path)
	if portal:
		portal.visible = true
		print("Portal is now visible.")
	else:
		print("Portal node not found: ", portal_node_path)

func print_node_tree(node: Node, indent: int = 0):
	print(String(" ").repeat(indent) + node.name)
	for child in node.get_children():
		print_node_tree(child, indent + 2)
