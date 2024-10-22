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
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 3
		}],
		"rewards": {
			#"recipes": [Inventory.inventory_dictionary["swordIron"]["id"]],
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
		"next_quests": ["quest_tutorial_1"],
		"completion_actions": [{
			"type": "open_portal",
			"path_node": "/root/instruction/Portal", 
			"name": "Portal"
		}],
		"dialog_data": [
			{"character": "player", "text": "Me: What a wonderful day! But it's time to head back home."},
			{"character": "player", "text": "Me: Oh, it seems there are coins scattered around. If I collect them, I can go home."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/instruction.tscn",
				"node_name": "/root/instruction/QuestNodes/quest_default",  # Path to the quest node in the scene
				"action": "show",  # Action to perform (e.g., "show", "hide")
			},
			{
				"stage": "res://Stages/Levels/instruction.tscn",
				"node_name": "/root/instruction/QuestNodes/quest_default",  # Path to the quest node in the scene
				"action": "hide",  # Action to perform (e.g., "show", "hide")
			}
		],
	},
	"quest_tutorial_1": {
		"quest_id": "quest_tutorial_1",
		"title": "Go back to home",
		"description": "Enter the portal and go to the Village",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
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
		"next_quests": ["quest_tutorial_2"],
		"dialog_data": [
			{"character": "player", "text": "Me: Good! The portal is open!"},
			{"character": "player", "text": "Me: Time to head back home to the village."},
		]
	},
	"quest_tutorial_2": {
		"quest_id": "quest_tutorial_2",
		"title": "Go back to Home",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
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
		"next_quests": ["quest_tutorial_3"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Greetings! It's been a while since we've seen you. Your forge is up the stairs and then left all the way at the end."},
			{"character": "player", "text": "Me: Thank you!"},
		]
	},
	"quest_tutorial_3": {
		"quest_id": "quest_tutorial_3",
		"title": "Go to Merchant",
		"description": "Find Merchant.",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "dealer",
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
		"next_quests": ["quest_tutorial_4"],
		"dialog_data": [
			{"character": "player", "text": "Me: Hmm, seems like I'm out of wood. Without it, I can't start working."},
			{"character": "player", "text": "Me: I should drop by the merchant—he might be able to help me."},
		]
	},
	"quest_tutorial_4": {
		"quest_id": "quest_tutorial_4",
		"title": "Buy Wood",
		"description": "Buy 5 wood.",
		"objectives": [{
			"type": Enums.QuestTypes.BUY,
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
		"next_quests": ["quest_tutorial_5"],
		"dialog_data": [
			{"character": "dealer", "text": "Merchant: Welcome to my shop! What can I get for you today?"},
			{"character": "player", "text": "Me: Hello! I need some wood for work in the forge."},
			{"character": "dealer", "text": "Merchant: Excellent choice! I have fine wood, just one coin apiece. Top quality at a great price!"},
		],
	},
	
	"quest_tutorial_5": {
		"quest_id": "quest_tutorial_5",
		"title": "Go to Home",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "house",
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["axeWooden"]["id"]],
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 10
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_tutorial_6"],
		"dialog_data": [
			{"character": "player", "text": "Me: Now that I have the wood, I can start making an axe."},
		],
	},
	
	"quest_tutorial_6": {
		"quest_id": "quest_tutorial_6",
		"title": "Craft Wooden Axe",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
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
		"next_quests": ["quest_tutorial_7"],
		"dialog_data": [
			{"character": "player", "text": "Me: Let's begin by processing the wood... Then add the details..."},
		],
	},
	
	"quest_tutorial_7": {
		"quest_id": "quest_tutorial_7",
		"title": "Serve Villager",
		"description": "Sell Wooden Axe to Villager",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
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
		"next_quests": ["quest_tutorial_8"],
		"dialog_data": [
			{"character": "player", "text": "Me: My first axe! Looks pretty good. Maybe I can take a break now."},
			{"character": "villager", "text": "Villager: Knock-knock!"},
			{"character": "player", "text": "Me: Who could that be?"},
			{"character": "villager", "text": "Villager: Good day! I heard you're back to smithing. I need a new axe. Can I buy one from you?"},
			{"character": "player", "text": "Me: Ok, I am coming!"},
		],
	},
	
	"quest_tutorial_8": {
		"quest_id": "quest_tutorial_8",
		"title": "Find the Village Elder",
		"description": "The Village Elder waits you.",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "king",
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
		"next_quests": ["quest_tutorial_9"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh right, the elder wanted to see me. I wonder what it's about?"},
			{"character": "player", "text": "Me: I should go visit him immediately."},
		],
	},

	"quest_tutorial_9": {
		"quest_id": "quest_tutorial_9",
		"title": "Craft 3 Wooden Axes",
		"description": "Use your forge to craft three wooden axes for the foresters.",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
			"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
			"qty": 3
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_tutorial_10"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Welcome back to the village! It's wonderful to see you working at your forge again."},
			{"character": "player", "text": "Me: Thank you, Elder. I heard you wanted to see me."},
			{"character": "king", "text": "Elder: Indeed, I did. Our foresters have been hard at work, but their axes are worn and dull. We could greatly use your skills to craft new ones."},
			{"character": "player", "text": "Me: I'd be happy to help. How many axes do they need?"},
			{"character": "king", "text": "Elder: Three sturdy wooden axes should suffice for now. It would mean a lot to them."},
			{"character": "player", "text": "Me: Consider it done. I'll start right away."},
			{"character": "king", "text": "Elder: Thank you, my friend. Your craftsmanship is invaluable to our village."},
		],
	},
	
	"quest_tutorial_10": {
		"quest_id": "quest_tutorial_10",
		"title": "Give the Elder 3 Wooden Axes",
		"description": "Come back to Elder.",
		"objectives": [{
			"type": Enums.QuestTypes.SELL_TO_KING,
			"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
			"qty": 3
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 20
			}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_1"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, I got enough axes. Let's go back to Elder."},
		],
	},

	"quest_first_chapter_1": {
		"quest_id": "quest_first_chapter_1",
		"title": "Go to the Caves Level 1",
		"description": "Use portal in the left side of village",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "level-1",
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_2"],
		"dialog_data": [
			{"character": "player", "text": "Me: Elder, I've finished the axes you requested."},
			{"character": "king", "text": "Elder: Excellent work! The foresters will be thrilled. You have our gratitude."},
			{"character": "player", "text": "Me: I'm glad I could help. Let me know if there's anything else you need."},
			{"character": "king", "text": "Elder: Actually, there is another matter I'd like to discuss with you. It's of great importance to our village."},
			{"character": "player", "text": "Me: What is it?"},
			{"character": "king", "text": "Elder: Perhaps you've noticed some unusual creatures near the caves recently?"},
			{"character": "player", "text": "Me: I've heard some rumors but haven't seen them myself."},
			{"character": "king", "text": "Elder: These creatures are emerging more frequently, and I fear they may pose a threat. There is an old prophecy that speaks of a skilled smith who will craft a legendary weapon to protect us..."},
			{"character": "player", "text": "Me: You think that smith could be me?"},
			{"character": "king", "text": "Elder: I believe so. Will you help us?"},
			{"character": "player", "text": "Me: Of course. Tell me what I need to do."},
			{"character": "king", "text": "Elder: Firstly, go to caves and collect some iron. You will need it."},
		],
	},
	
	"quest_first_chapter_2": {
		"quest_id": "quest_first_chapter_2",
		"title": "Go to the Caves Level 2",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "level-2",
			"qty": 1
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_3"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, I can get some wood here."},
			{"character": "player", "text": "Me: Or I can go to the caves immediately."},
		],
	},
	
	"quest_first_chapter_3": {
		"quest_id": "quest_first_chapter_3",
		"title": "Collect 10 iron",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": "iron",
			"qty": 10
		}],
		"rewards": {
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_4"],
		"dialog_data": [
			{"character": "player", "text": "Me: These caves are darker than I remember."},
			{"character": "player", "text": "Me: I need to find iron ore and watch out for any obstacles."},
		],
	},
	
	"quest_first_chapter_4": {
		"quest_id": "quest_first_chapter_4",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "king",
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["ironIngot"]["id"], Inventory.inventory_dictionary["swordIron"]["id"], Inventory.inventory_dictionary["spearIron"]["id"]],
			#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_5"],
		"dialog_data": [
			{"character": "player", "text": "Me: Elder, I've collected the 10 units of iron ore you requested."},
			{"character": "king", "text": "Elder: Excellent work! With this iron, we can begin crafting stronger weapons for our defenders."},
			{"character": "king", "text": "Elder: You'll need to smelt the iron ore into iron ingots. Remember, raw ore isn't suitable for weapon-making."},
			{"character": "player", "text": "Me: Understood. I'll use the forge to smelt the ore."},
			{"character": "king", "text": "Elder: Here, take these as well—a new recipe for crafting an iron sword and spear. They will serve our villagers well."},
			{"character": "player", "text": "Me: Thank you! I'll make good use of them."},
		],
	},

	"quest_first_chapter_5": {
		"quest_id": "quest_first_chapter_5",
		"title": "Craft iron ingot",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
			"item_id": Inventory.inventory_dictionary["ironIngot"]["id"],
			"qty": 3
		}],
		"rewards": {
			#"recipes": [Inventory.inventory_dictionary["ironIngot"]["id"]],
						#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_6"],
		"dialog_data": [],
	},


	"quest_first_chapter_6": {
		"quest_id": "quest_first_chapter_6",
		"title": "Serve clients",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"item_id": null,
			"qty": 3
		}],
		"rewards": {
			#"recipes": [Inventory.inventory_dictionary["ironIngot"]["id"]],
						#"goods": [{
			#	"item_id": Inventory.inventory_dictionary["coin"]["id"],
			#	"qty": 20
			#}],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_7"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Hello! I heard you're crafting weapons again. Could you make me something?"},
			{"character": "player", "text": "Me: Yes, sure!"},
		],
	},



	"quest_48": {
		"quest_id": "quest_48",
		"title": "Advanced Blacksmithing",
		"description": "Craft an Iron Sword.",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
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
			"type": Enums.QuestTypes.VISIT,
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
			"type": Enums.QuestTypes.VISIT,
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
			"type": Enums.QuestTypes.VISIT,
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
			"type": Enums.QuestTypes.BUY,
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
			"type": Enums.QuestTypes.SELL,
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
			"type": Enums.QuestTypes.SELL_TO_KING,
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
			"type": Enums.QuestTypes.SELL,
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
		
		# Show quest nodes if any
		if quest_data.has("quest_actions"):
			process_quest_actions(quest_data["quest_actions"], "start")

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
		elif key == "experience":
			# Add experience logic
			pass
		elif key == "recipes":
			for recipe_id in rewards["recipes"]:
				Inventory.unlock_recipe(recipe_id)
				print("Unlocked recipe for item ID:", recipe_id)

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
			
		# Hide quest objects if needed
		var quest_data = quest_database.get(quest.quest_id)
		if quest_data != null and quest_data.has("quest_actions"):
			process_quest_actions(quest_data["quest_actions"], "complete")

func update_quest():
	update_quest_ui.emit(active_quests)

func update_objective_progress(type: int, item_id: String, qty: int):
	print('type ', type, 'item_id ', item_id, 'qty ', qty)
	for quest in active_quests:
		for objective in quest.objectives:
			var target_item_id = str(objective.item_id);
			
			if type == Enums.QuestTypes.COLLECT and objective.type == Enums.QuestTypes.COLLECT and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.VISIT and objective.type == Enums.QuestTypes.VISIT and target_item_id == item_id:
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.CRAFT and objective.type == Enums.QuestTypes.CRAFT and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)
				
			if type == Enums.QuestTypes.BUY and objective.type == Enums.QuestTypes.BUY and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.SELL and objective.type == Enums.QuestTypes.SELL:
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.SELL_TO_KING and objective.type == Enums.QuestTypes.SELL_TO_KING:
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

func process_quest_actions(actions_array, quest_phase):
	print('process_quest_actions', quest_phase)
	var current_stage_path = SceneManager.get_current_scene_path()
	for action_data in actions_array:
		var action_stage = action_data.get("stage", "")
		var node_name = action_data.get("node_name", "")
		var action = action_data.get("action", "")

		# Check if the action's stage matches the current stage
		if action_stage != current_stage_path:
			continue  # Skip actions not related to the current stage
		
		# Determine if the action should be processed during the quest phase
		if quest_phase == "start" and action == "show":
			update_quest_node(node_name, "show")
		elif quest_phase == "complete" and action == "hide":
			update_quest_node(node_name, "hide")
		# Add more conditions if needed

func update_quest_node(node_name, action):
	print('update_quest_node ', node_name, ' ', action)
	var current_stage = SceneManager.get_current_scene()
	if current_stage == null:
		print("Current stage is null.")
		return

	print('current_stage.name', current_stage.name)
	print('NODE : ', get_node("/root/instruction"), " ", node_name)
	print('node_name', get_node(node_name))
	# Find the node by name within the current stage
	var quest_node = current_stage.get_node(node_name)
	print('->',quest_node)
	if quest_node:
		if action == "show":
			quest_node.visible = true
			#enable_collision(quest_node, true)
		elif action == "hide":
			quest_node.visible = false
			#enable_collision(quest_node, false)
		elif action == "remove":
			quest_node.queue_free()
		else:
			print("Unknown action for quest node:", action)
	else:
		print("Quest node not found:", node_name)

func on_stage_changed():
	# Re-process quest actions for active quests
	for quest in active_quests:
		var quest_data = quest_database.get(quest.quest_id)
		if quest_data != null and quest_data.has("quest_actions"):
			# Process quest actions relevant to the current stage
			process_quest_actions(quest_data["quest_actions"], "start")
