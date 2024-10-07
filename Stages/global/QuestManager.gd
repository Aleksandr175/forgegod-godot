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
var completed_quest_ids: Array = []
var quest_database = {
	"quest_default": {
		"quest_id": "quest_default",
		"title": "Wonderful day!",
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
			{"character": "player", "text": "Me: What a wonderful day! But it's time to head back home."},
			{"character": "player", "text": "Me: Oh, it seems there are coins scattered around. If I collect them, I can go home."},
		]
	},
	"quest_20": {
		"quest_id": "quest_20",
		"title": "Go back to home",
		"description": "Enter the portal and go to the Village",
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
			{"character": "player", "text": "Me: Good! The portal is open!"},
			{"character": "player", "text": "Me: Time to head back home to the village."},
		]
	},
	"quest_30": {
		"quest_id": "quest_30",
		"title": "Go back to Home",
		"description": "",
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
		"next_quests": ["quest_40"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Greetings! It's been a while since we've seen you. Your forge is up the stairs and then left all the way at the end."},
			{"character": "player", "text": "Me: Thank you!"},
		]
	},
	"quest_40": {
		"quest_id": "quest_40",
		"title": "Go to Merchant",
		"description": "Find Merchant.",
		"objectives": [{
			"type": "dealer",
			"item_id": null,
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_41"],
		"dialog_data": [
			{"character": "player", "text": "Me: Hmm, seems like I'm out of wood. Without it, I can't start working."},
			{"character": "player", "text": "Me: I should drop by the merchant—he might be able to help me."},
		]
	},
	"quest_41": {
		"quest_id": "quest_41",
		"title": "Buy Wood",
		"description": "Buy 5 wood.",
		"objectives": [{
			"type": "buy",
			"item_id": Inventory.inventory_dictionary["wood"]["id"],
			"qty": 5
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_42"],
		"dialog_data": [
			{"character": "dealer", "text": "Merchant: Welcome to my shop! What can I get for you today?"},
			{"character": "player", "text": "Me: Hello! I need some wood for work in the forge."},
			{"character": "dealer", "text": "Merchant: Excellent choice! I have fine wood, just one coin apiece. Top quality at a great price!"},
		],
	},
	
	"quest_42": {
		"quest_id": "quest_42",
		"title": "Go to Home",
		"description": "",
		"objectives": [{
			"type": "visit",
			"item_id": "house",
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_43"],
		"dialog_data": [
			{"character": "player", "text": "Me: Now that I have the wood, I can start making an axe."},
		],
	},
	
	"quest_43": {
		"quest_id": "quest_43",
		"title": "Craft Wooden Axe",
		"description": "",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_44"],
		"dialog_data": [
			{"character": "player", "text": "Me: Let's begin by processing the wood... Then add the details..."},
		],
	},
	
	"quest_44": {
		"quest_id": "quest_44",
		"title": "Serve Villager",
		"description": "Sell weapon to Villager",
		"objectives": [{
			"type": "sell",
			"item_id": null,
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_45"],
		"dialog_data": [
			{"character": "player", "text": "Me: My first axe! Looks pretty good. Maybe I can take a break now."},
			{"character": "villager", "text": "Villager: Knock-knock!"},
			{"character": "player", "text": "Me: Who could that be?"},
			{"character": "villager", "text": "Villager: Good day! I heard you're back to smithing. I need a new axe. Can I buy one from you?"},
			{"character": "player", "text": "Me: Ok, I am coming!"},
		],
	},
	
	# quest to sell axe to villager



	"quest_45": {
		"quest_id": "quest_45",
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
			{"character": "player", "text": "Me: Good! Portal opened!"},
			{"character": "player", "text": "Me: Let's go to village. I have some deals there."},
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
	GlobalSignals.new_game_started.connect(start_timer)
	start_timer()

func start_timer():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", _initialize_ui)
	timer.start()	

func _initialize_ui():
	load_quests()

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
		completed_quest_ids.append(quest.quest_id)
		print("Quest completed: ", quest.title, quest.quest_id)
		
		# Handle post-completion actions
		process_completion_actions(quest)

		# Save the updated completed quests to GameState
		GameState.completed_quest_ids = completed_quest_ids.duplicate()
		GameState.save_game()
		
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

func process_completion_actions(quest):
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

func load_quests():
	completed_quest_ids = GameState.completed_quest_ids.duplicate()
	active_quests.clear()
	
	# If there are completed quests
	if completed_quest_ids.size() > 0:
		# Get the last completed quest ID
		var last_completed_quest_id = completed_quest_ids[completed_quest_ids.size() - 1]
		
		# Find the quest data in quest_database
		var last_completed_quest_data = quest_database.get(last_completed_quest_id)
		
		if last_completed_quest_data != null:
			# complete actions after last quest:
			print('last_completed_quest_data', last_completed_quest_data)
			process_completion_actions(last_completed_quest_data)

			# Get the next quests
			if last_completed_quest_data.has("next_quests"):
				var next_quests = last_completed_quest_data["next_quests"]
				# Start the first next quest
				if next_quests.size() > 0:
					start_quest(next_quests[0])
				else:
					print("No next quests available.")
			else:
				print("No next quests defined for this quest.")
		else:
			print("Last completed quest not found in quest_database.")
	else:
		# No quests have been completed yet; start the initial quest
		start_quest('quest_default')  # Replace 'quest_10' with your starting quest ID

	#active_quests = GameState.active_quests.duplicate()
