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
	"quest_1": {
		"quest_id": "quest_1",
		"title": "Need some money",
		"description": "Collect coins.",
		"objectives": [{
			"description": "Collect 3 coins",
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
				"item_id": Inventory.inventory_dictionary["swordCopper"]["id"],
				"qty": 10
			}],
			"experience": 10
		},
		"prerequisites": [],
		"next_quests": ["quest_2"]
	},
	"quest_2": {
		"quest_id": "quest_2",
		"title": "Sword time",
		"description": "Craft a Copper Sword.",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["swordCopper"]["id"],
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
		"next_quests": ["quest_3"]
	},
	"quest_3": {
		"quest_id": "quest_3",
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
		"next_quests": ["quest_4"]
	},
	"quest_4": {
		"quest_id": "quest_4",
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
		"next_quests": ["quest_10"]
	},
	"quest_10": {
		"quest_id": "quest_10",
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
}

func _ready():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", _initialize_ui)
	timer.start()

func _initialize_ui():
	start_quest('quest_9')

func start_quest(quest_id: String):
	var quest_data = quest_database[quest_id]
	
	if quest_data != null:
		# Check if prerequisites are completed
		#for prereq in quest_data["prerequisites"]:
		#	if !completed_quests.has(prereq):
		#		print("Cannot start quest: ", quest_id, ". Prerequisite quest not completed: ", prereq)
		#		return
		
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
		
		# Start next quests
		for next_quest_id in quest_database[quest.quest_id]["next_quests"]:
			start_quest(next_quest_id)

func update_quest():
	update_quest_ui.emit(active_quests)

func update_objective_progress(type: String, item_id: String, qty: int):
	print('type', type, 'item_id', item_id, 'qty', qty)
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
				do_progress(objective, qty, quest)

func do_progress(objective, qty, quest):
	objective.progress(qty)
	update_quest()
	if objective.is_completed():
		#print("Objective completed: ", objective.description)
		complete_quest(quest)
	emit_signal("quest_updated", quest)
