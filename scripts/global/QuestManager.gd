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
			"qty": 5
		}],
		"rewards": {
			#"recipes": [Inventory.inventory_dictionary["swordIron"]["id"]],
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 10
		},
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
	},
	"quest_tutorial_1": {
		"quest_id": "quest_tutorial_1",
		"title": "Enter the portal",
		"description": "Enter the portal and go to the Village",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.VILLAGE,
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
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
			"item_id": Enums.QuestTargetObjects.HOUSE,
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"next_quests": ["quest_tutorial_3"],
		"dialog_data": [
			{"character": "soldier", "text": "Soldier: Greetings! You are knew blacksmith's apprentice, aren't you? We were waiting for you. The forge is up the stairs behind me and then left all the way at the end."},
			{"character": "player", "text": "Me: Thank you!"},
		]
	},
	"quest_tutorial_3": {
		"quest_id": "quest_tutorial_3",
		"title": "Go to Merchant",
		"description": "Find Merchant.",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.DEALER,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_tutorial_4"],
		"dialog_data": [
			{"character": "player", "text": "Me: Hmm, where is my master? I can't wait. I think I can't start working without wood."},
			{"character": "player", "text": "Me: I should go to the merchant. He might be able to help me."},
			{"character": "player", "text": "Me: I saw a shop not so far from here."},
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
			"experience": 5
		},
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
			"item_id": Enums.QuestTargetObjects.HOUSE,
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["axeWooden"]["id"]],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_tutorial_6"],
		"dialog_data": [
			{"character": "player", "text": "Me: Now that I have the wood, I can start making an axe."},
			{"character": "player", "text": "Me: May be master has returned."},
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
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_tutorial_7"],
		"dialog_data": [
			{"character": "player", "text": "Me: He is still not here."},
			{"character": "player", "text": "Me: Oh, let's craft the wooden axe anyway..."},
		],
	},
	
	"quest_tutorial_7": {
		"quest_id": "quest_tutorial_7",
		"title": "Serve Villager",
		"description": "Sell Wooden Axe to Villager",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_1",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"next_quests": ["quest_tutorial_8"],
		"dialog_data": [
			{"character": "player", "text": "Me: My first axe! Looks pretty good. Master would be pleased. Maybe I can take a break now."},
			{"character": "villager", "text": "Villager: Knock-knock!"},
			{"character": "player", "text": "Me: Who could that be?"},
			{"character": "villager", "text": "Villager: Good day! I heard you're a new smith. I need a new wooden axe. Can I buy one?"},
			{"character": "player", "text": "Me: Ok, sure!"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_to_villager",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},
	
	"quest_tutorial_8": {
		"quest_id": "quest_tutorial_8",
		"title": "Find the Village Elder",
		"description": "The Village Elder waits you.",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_tutorial_9"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh right, I can visit the Elder and ask him about my mentor."},
			{"character": "player", "text": "Me: I should go to visit him immediately."},
		],
	},

	"quest_tutorial_9": {
		"quest_id": "quest_tutorial_9",
		"title": "Craft 3 Wooden Axes",
		"description": "Use your furnace at home to craft wooden axes",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
			"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
			"qty": 3
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_tutorial_10"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Welcome to the village! It's wonderful to see you came to help our smith."},
			{"character": "player", "text": "Me: Thank you, Elder. But I can't find my mentor. Do you know where he is?"},
			{"character": "king", "text": "Elder: Oh, no. I don't, but I am sure he will be back soon."},
			{"character": "player", "text": "Me: Ok, can I help you somehow now?"},
			{"character": "king", "text": "Elder: Indeed! Our foresters have been hard at work, but their axes are worn and dull. We could greatly use your skills to craft new ones."},
			{"character": "player", "text": "Me: I'd be happy to help. How many axes do they need?"},
			{"character": "king", "text": "Elder: Three sturdy wooden axes should suffice for now. It would mean a lot to them."},
			{"character": "player", "text": "Me: Consider it done. I'll start right away."},
			{"character": "king", "text": "Elder: Thank you, my friend."},
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
		"title": "Go to the Forest",
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
			{"character": "king", "text": "Elder: These creatures are emerging more frequently, and I fear they may pose a threat. "},
			{"character": "king", "text": "Elder: Will you help us?"},
			{"character": "player", "text": "Me: Absolutely! Tell me what I need to do."},
			{"character": "king", "text": "Elder: Firstly, go to Iron Cave and collect some iron. You will need it."},
		],
	},
	
	"quest_first_chapter_2": {
		"quest_id": "quest_first_chapter_2",
		"title": "Go to the Iron Cave",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": "level-2",
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_3"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, I can get some wood here."},
			{"character": "player", "text": "Me: Or I can go to the Iron Cave immediately."},
		],
	},
	
	"quest_first_chapter_3": {
		"quest_id": "quest_first_chapter_3",
		"title": "Collect 10 iron",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["iron"]["id"],
			"qty": 10
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_4"],
		"dialog_data": [
			{"character": "player", "text": "Me: These caves are darker than I thougth."},
			{"character": "player", "text": "Me: I need to find iron ore and watch out for any obstacles."},
		],
	},
	
	"quest_first_chapter_4": {
		"quest_id": "quest_first_chapter_4",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["ironIngot"]["id"], Inventory.inventory_dictionary["swordIron"]["id"], Inventory.inventory_dictionary["spearIron"]["id"]],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_5"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, I should return to the Elder."},
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
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_6"],
		"dialog_data": [
			{"character": "player", "text": "Me: Elder, I've collected iron ore you requested."},
			{"character": "king", "text": "Elder: Excellent work! With this iron, we can begin crafting stronger weapons for our defenders."},
			{"character": "king", "text": "Elder: You'll need to smelt the iron ore into iron ingots. Remember, raw ore isn't suitable for weapon-making."},
			{"character": "player", "text": "Me: Understood. I'll use the forge to smelt the ore."},
			{"character": "king", "text": "Elder: Here, take these as well—a new recipe for crafting an iron sword and spear. They will serve our villagers well."},
			{"character": "player", "text": "Me: Thank you! I'll make good use of them."},
		],
	},

	"quest_first_chapter_6": {
		"quest_id": "quest_first_chapter_6",
		"title": "Serve First Villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_2",
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_6-2"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Hello! I heard you're crafting weapons now. Could you make me something?"},
			{"character": "player", "text": "Me: Yes, sure!"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_2",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},
	
	"quest_first_chapter_6-2": {
		"quest_id": "quest_first_chapter_6-2",
		"title": "Serve Second Villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_3",
			"qty": 1
		}],
		"rewards": {
			"goods": [{
				"item_id": Inventory.inventory_dictionary["coin"]["id"],
				"qty": 10
			}],
			"experience": 5
		},
		"next_quests": ["quest_first_chapter_7"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Hi! I need iron sword, please!"},
			{"character": "player", "text": "Me: Ok, one moment"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_2",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},
	
	"quest_first_chapter_7": {
		"quest_id": "quest_first_chapter_7",
		"title": "Find the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_8"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Thanks a lot!"},
			{"character": "player", "text": "Me: You are welcome."},
			{"character": "player", "text": "Me: Ok, I need to find the Elder."},
		],
	},

	# Quest 16: Meeting with the Village Elder

	"quest_first_chapter_8": {
		"quest_id": "quest_first_chapter_8",
		"title": "Find library",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.LIBRARY,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_first_chapter_9"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Excellent work. Our defenders are now well-armed. However, I recalled something important."},
			{"character": "player", "text": "Me: What is it?"},
			{"character": "king", "text": "Elder: There might be ancient records in our library on how to seal the ancient evil that is said to be awakening in the depths of the caves. "},
			{"character": "king", "text": "Elder: I ask you to go there and find this information."},
			{"character": "player", "text": "Me: I'll head to the library immediately and try to find whatever I can."},
		],
	},

	"quest_first_chapter_9": {
		"quest_id": "quest_first_chapter_9",
		"title": "Find Altar",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.ALTAR,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_1"],
		"dialog_data": [
			{"character": "player", "text": "Me: So, I should find something unusual. What could it be?"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Library.tscn",
				"node_name": "/root/Library/QuestNodes/quest_prophecy",
				"action": Enums.QuestActions.SHOW,
			},
			{
				"stage": "res://Stages/Levels/Library.tscn",
				"node_name": "/root/Library/QuestNodes/quest_prophecy",  # Path to the quest node in the scene
				"action": Enums.QuestActions.HIDE,
			}
		],
	},

	"quest_second_chapter_1": {
		"quest_id": "quest_second_chapter_1",
		"title": "Find Elder",
		"description": "Returning to the Elder with the Prophecy",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_2"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh, prophecy! Let's go back to Elder and tell him what I found."},
		],
	},
	
	"quest_second_chapter_2": {
		"quest_id": "quest_second_chapter_2",
		"title": "Go to the Emerald Cave",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'level-3',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [
			{"type": "unlock_level", "level_id": "level-3"},
		],
		"next_quests": ["quest_second_chapter_3"],
		"dialog_data": [
			{"character": "player", "text": "Me: I found an altar with prophecy in the library. It mentions that to seal the ancient evil, we need rare materials and legendary artifacts."},
			{"character": "king", "text": "Elder: This is important information. Let's begin by searching for these materials."},
			{"character": "king", "text": "Elder: Please gather Emeraldite while I try to discover where to find the legendary artifacts."},
			{"character": "king", "text": "Elder: As I know you can find it deeper in caves."},
		],
	},
	
	"quest_second_chapter_3": {
		"quest_id": "quest_second_chapter_3",
		"title": "Collect Emerald",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["emerald"]["id"],
			"qty": 5
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_4"],
		"dialog_data": [
			{"character": "player", "text": "Me: Wow! It is much darker here"},
			{"character": "player", "text": "Me: Let's try to find this Emerald"},
		],
	},
	
	"quest_second_chapter_4": {
		"quest_id": "quest_second_chapter_4",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_5"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok! I collected necessary Emerald."},
			{"character": "player", "text": "Me: I should go back to the Elder"},
		],
	},
	
	"quest_second_chapter_5": {
		"quest_id": "quest_second_chapter_5",
		"title": "Collect Tear of the Heavens",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["tearOfTheHeavens"]["id"],
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_6"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Excellent work with the Emeraldite. I believe I’ve discovered something about the first artifact."},
			{"character": "player", "text": "Me: That’s wonderful news! Where can I find it?"},
			{"character": "king", "text": "Elder: This artifact is called the Tear of the Heavens. According to legend, it’s a powerful crystal that fell from the sky, carrying extraordinary strength"},
			{"character": "king", "text": "Elder: As far as I can tell, it’s located right here in our village."},
			{"character": "player", "text": "Me: In the village? But where exactly?"},
			{"character": "king", "text": "Elder: There’s a path behind the shop that leads up the hill. The writings say to follow it to reach the Tear’s resting place."},
			{"character": "player", "text": "Me: Got it. Thank you for the guidance, Elder. I’ll head up the path and find the Tear of the Heavens."},
			{"character": "king", "text": "Elder: Take care. The path may not be easy, and remember — this artifact holds ancient magic. Guard it well."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_tear_heavens",
				"action": Enums.QuestActions.SHOW,
			},
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_tear_heavens",  # Path to the quest node in the scene
				"action": Enums.QuestActions.HIDE,
			}
		],
	},
	
	"quest_second_chapter_6": {
		"quest_id": "quest_second_chapter_6",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_7"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh! Let's go back to the Elder."},
		],
	},


	"quest_second_chapter_7": {
		"quest_id": "quest_second_chapter_7",
		"title": "Go to home",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.HOUSE,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_8"],
		"dialog_data": [
			{"character": "king", "text": "Elder: You've done well, finding the Tear of the Heavens. This artifact is truly remarkable, and I'm grateful you retrieved it safely."},
			{"character": "player", "text": "Me: Thank you, Elder. Have you learned anything about the next artifact?"},
			{"character": "king", "text": "Elder: Not yet, I’m afraid. The writings are obscure, and it may take me a bit more time to uncover the next clue. In the meantime, there’s another way you could be of help."},
			{"character": "player", "text": "Me: Of course. What can I do?"},
			{"character": "king", "text": "Elder: The villagers have been eagerly awaiting your help."},
			{"character": "king", "text": "Elder: They’ve heard you found emerald, and several of them are already waiting for you at your house. They’re in need of weapons that you can forge."},
			{"character": "player", "text": "Me: Understood. I’ll see to their orders and return once they’re done."},
			{"character": "king", "text": "Elder: Thank you. These weapons will strengthen the village’s defenses, and your work will not go unnoticed."},
		],
	},
	
	
	"quest_second_chapter_8": {
		"quest_id": "quest_second_chapter_8",
		"title": "Serve Wolf Hunter",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_second_chapter_3",
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["spearEmerald"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_9"],
		"dialog_data": [
			{"character": "villager", "text": "Wolf Hunter: Hi! I need a spear that can withstand the strength of a wolf and cut cleanly through fur and hide. Could you forge one for me?"},
			{"character": "player", "text": "Me: An emerald spear, you say? It sounds like a worthy challenge. I’ll make sure it’s sharp and durable"},
			{"character": "villager", "text": "Wolf Hunter: Thank you. This weapon could make all the difference for my hunts."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_3",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},

	"quest_second_chapter_9": {
		"quest_id": "quest_second_chapter_9",
		"title": "Serve Collector",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_second_chapter_4",
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["maceEmerald"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_10"],
		"dialog_data": [
			{"character": "villager", "text": "Collector: Good day! I’ve been admiring your work and was hoping you could make me something unique—a mace, crafted from emerald."},
			{"character": "villager", "text": "Collector: It’s not for combat, but rather for the pleasure of owning such a rare piece."},
			{"character": "player", "text": "Me: An emerald mace... It will be as impressive to behold as it is to hold. I’ll see to it."},
			{"character": "villager", "text": "Collector: Wonderful! I’m certain it will be the centerpiece of my collection."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_3",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},

	"quest_second_chapter_10": {
		"quest_id": "quest_second_chapter_10",
		"title": "Serve Wizard's Apprentice",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": "customer_second_chapter_5",
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["staffEmerald"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_11"],
		"dialog_data": [
			{"character": "villager", "text": "Wizard's Apprentice: Hello! My master, the village wizard, has sent me here with a special request."},
			{"character": "villager", "text": "Wizard's Apprentice: He believes an emerald-tipped staff will amplify my abilities and help me in my studies. Could you make one for me?"},
			{"character": "player", "text": "Me: Of course. A staff for a budding wizard — it sounds like a fascinating project."},
			{"character": "villager", "text": "Wizard's Apprentice: Thank you! My master says it will make a great difference in my training."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/house_level.tscn",
				"node_name": "/root/house_level/QuestNodes/quest_sell_3",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},
	
	"quest_second_chapter_11": {
		"quest_id": "quest_second_chapter_11",
		"title": "Visit the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_12"],
		"dialog_data": [
			{"character": "player", "text": "Me: That's all for today. Let's go back to the Elder"},
		],
	},

	"quest_second_chapter_12": {
		"quest_id": "quest_second_chapter_12",
		"title": "Visit Dark Cave",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'level-5',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [
			{"type": "unlock_level", "level_id": "level-5"},
		],
		"next_quests": ["quest_second_chapter_13"],
		"dialog_data": [
			{"character": "king", "text": "Elder: It’s good to see you, apprentice. I’ve finally discovered where the Mountain’s Heart is located—it’s hidden deep within the most remote corner of the cave."},
			{"character": "king", "text": "Elder: But beware, the path to it is treacherous, and many have lost their way in those depths."},
			{"character": "player", "text": "Me: I’ll be careful. If this artifact is as powerful as you say, I’ll make sure it doesn’t fall into the wrong hands."},
			{"character": "king", "text": "Elder: Thank you. And... if you happen to find any sign of your mentor, please let me know. It’s possible he went after this very artifact."},
		],
	},
	
	"quest_second_chapter_13": {
		"quest_id": "quest_second_chapter_13",
		"title": "Find the Mentor",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.MENTOR,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_14"],
		"dialog_data": [
			{"character": "player", "text": "Me: There is it. I should look around and find any sign of my mentor."},
		],
	},

	"quest_second_chapter_14": {
		"quest_id": "quest_second_chapter_14",
		"title": "Find the Mountain's Heart",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["mountainsHeart"]["id"],
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_15"],
		"dialog_data": [
			{"character": "player", "text": "Me: This… this is my mentor. He must have been searching for the Mountain's Heart as well. He didn’t make it…"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/level-5.tscn",
				"node_name": "/root/level-5/QuestNodes/quest_get_mountain_heart",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},

	"quest_second_chapter_15": {
		"quest_id": "quest_second_chapter_15",
		"title": "Come back to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_16"],
		"dialog_data": [
			{"character": "player", "text": "Me: Wow! I found it! Let's go back to the Elder"},
		],
	},

	"quest_second_chapter_16": {
		"quest_id": "quest_second_chapter_16",
		"title": "Go to Twilightite cave",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'level-4',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [
			{"type": "unlock_level", "level_id": "level-5"},
		],
		"next_quests": ["quest_second_chapter_17"],
		"dialog_data": [
			{"character": "player", "text": "Me: Elder, I… I found my mentor. He… he didn’t survive. It looks like he was searching for the Mountain’s Heart too but… something stopped him."},
			{"character": "king", "text": "Elder: ... (sighs deeply) ... This is painful news, apprentice. Your mentor was a brave soul, but it seems this ancient darkness is stronger than we thought."},
			{"character": "king", "text": "Elder: If he could not withstand it, we must act quickly to prepare the village."},
			{"character": "player", "text": "Me: What do you need me to do?"},
			{"character": "king", "text": "Elder: To strengthen our defenses, we’ll need a special material called Twilightite."},
			{"character": "king", "text": "Elder: It’s a rare, purple mineral found in the caves, and its properties could prove invaluable."},
			{"character": "king", "text": "Elder: Please, gather as much as you can — we’ll need it to forge powerful weapons."},
			{"character": "player", "text": "Me: I understand. I’ll head back to the caves and bring back the Twilightite."},
		],
	},
	
	"quest_second_chapter_17": {
		"quest_id": "quest_second_chapter_17",
		"title": "Collect Twilightite",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["twilightite"]["id"],
			"qty": 3
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_18"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, let's find Twilightite."},
		],
	},
	
	"quest_second_chapter_18": {
		"quest_id": "quest_second_chapter_18",
		"title": "Come back to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["twilightiteSword"]["id"]],
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_19"],
		"dialog_data": [
			{"character": "player", "text": "Me: Come back to the Elder as soon as posible."},
		],
	},

	"quest_second_chapter_19": {
		"quest_id": "quest_second_chapter_19",
		"title": "Serve first sodier",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'soldier_1',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_20"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Thank you for gathering the Twilightite. It is more powerful than I imagined, and with it, we can forge weapons to strengthen our defenses."},
			{"character": "player", "text": "Me: What do you need me to make?"},
			{"character": "king", "text": "Elder: Three soldiers have requested weapons that will aid them in facing the coming evil. Each one has specific requirements."},
			{"character": "king", "text": "Elder: You’ll need to forge an iron broadsword, a steel double-headed axe, and a Twilight Blade. They’re waiting for you to speak with them."},
			{"character": "player", "text": "Me: Understood. I’ll speak with each soldier and get started on their weapons."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_soldiers",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_second_chapter_20": {
		"quest_id": "quest_second_chapter_20",
		"title": "Serve first sodier",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'soldier_1',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["broadswordIron"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_21"],
		"dialog_data": [
			{"character": "soldier", "text": "Soldier: We’re all feeling the tension in the air. The darkness is coming, and we need every advantage we can get. "},
			{"character": "soldier", "text": "Soldier: An iron broadsword — strong and reliable—is what I need. With it, I’ll stand guard and defend the village to my last breath."},
			{"character": "player", "text": "Me: I’ll make sure your sword is as strong as your resolve."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_soldiers",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_second_chapter_21": {
		"quest_id": "quest_second_chapter_21",
		"title": "Serve second sodier",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'soldier_2',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["doubleBitAxeSteel"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_22"],
		"dialog_data": [
			{"character": "soldier", "text": "Soldier: If the darkness dares to threaten our home, it will meet my steel axe."},
			{"character": "soldier", "text": "Soldier: Double-headed, balanced, and fierce—that’s the kind of weapon I need to face whatever comes from the caves."},
			{"character": "soldier", "text": "Soldier: This axe will give me the strength to strike down anything in my path."},
			{"character": "player", "text": "Me: I’ll craft an axe worthy of your courage."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_soldiers",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_second_chapter_22": {
		"quest_id": "quest_second_chapter_22",
		"title": "Serve third sodier",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'soldier_3',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [{
			"type": "unlock_recipes", "recipes": [Inventory.inventory_dictionary["twilightiteSword"]["id"]],
		}],
		"next_quests": ["quest_second_chapter_23"],
		"dialog_data": [
			{"character": "soldier", "text": "Soldier: I’ve heard that Twilightite holds mysterious power… that it can channel energies beyond our understanding."}, 
			{"character": "soldier", "text": "Soldier: I’ll need every bit of that power in the battles to come. Could you forge me a blade from this material? With it, I’ll have the strength to cut through even the shadows."},
			{"character": "player", "text": "Me: A Twilight Blade—yes, it will be a weapon unlike any other. I’ll make sure it’s ready for you."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_soldiers",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_second_chapter_23": {
		"quest_id": "quest_second_chapter_23",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [],
		"next_quests": ["quest_second_chapter_24"],
		"dialog_data": [
			{"character": "player", "text": "Me: Uh, ok, let's go back to the elder"},
		],
	},

	"quest_second_chapter_24": {
		"quest_id": "quest_second_chapter_24",
		"title": "Go to the Deep Forest",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'level-6',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [
			{"type": "unlock_level", "level_id": "level-6"},
		],
		"next_quests": ["quest_second_chapter_25"],
		"dialog_data": [
			{"character": "king", "text": "Elder: You did excellent work assisting the soldiers. Now, I have news about the final artifact."},
			{"character": "king", "text": "Elder: It’s called the Breath of the Forest—an ancient wood with magical properties."},
			{"character": "king", "text": "Elder: It’s hidden deep within the forest, which can be reached by traveling through the entire cave. "},
			{"character": "king", "text": "Elder: At the cave’s exit, you’ll find a new snowy biome. Among the trees there, you will find this artifact."},
			{"character": "player", "text": "Me: Thank you for the guidance, Elder. I’ll set off immediately."},
			{"character": "king", "text": "Elder: Take care. The forest holds many secrets, and we need this artifact to complete your great task."},
		],
	},

	"quest_second_chapter_25": {
		"quest_id": "quest_second_chapter_25",
		"title": "Find the Breath of the Forest",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.COLLECT,
			"item_id": Inventory.inventory_dictionary["breathForest"]["id"],
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_26"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh, it is freezing. Let's find it quickly and go back to village."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/level-6.tscn",
				"node_name": "/root/level-6/QuestNodes/quest_breathForest",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_second_chapter_26": {
		"quest_id": "quest_second_chapter_26",
		"title": "Go back to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_27"],
		"dialog_data": [
			{"character": "player", "text": "Me: I should talk with the Elder about this artifact."},
		],
	},

	"quest_second_chapter_27": {
		"quest_id": "quest_second_chapter_27",
		"title": "Find first villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_1',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_28"],
		"dialog_data": [
			{"character": "king", "text": "Elder: You’ve found all three artifacts. This is incredible… but fear has gripped the villagers. Even ordinary people want to be prepared to defend themselves. "},
			{"character": "king", "text": "Elder: Help them by crafting weapons for three villagers. They’re waiting for you by their homes."},
			{"character": "player", "text": "Me: Of course, I’ll make weapons for them. I’ll return once I’m done."},
		],
	},

	"quest_second_chapter_28": {
		"quest_id": "quest_second_chapter_28",
		"title": "Serve first villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'villager_1',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_29"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: The rumors of darkness are troubling, and I want to be ready. Can you make me a reliable weapon? Even if I never use it, it will give me peace of mind."},
			{"character": "player", "text": "Me: Of course, I’ll make something that helps you feel safe."},
		],
	},
	
	"quest_second_chapter_29": {
		"quest_id": "quest_second_chapter_29",
		"title": "Find second villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_2',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_29_2"],
		"dialog_data": [],
	},

	"quest_second_chapter_29_2": {
		"quest_id": "quest_second_chapter_29_2",
		"title": "Serve second villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'villager_2',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_30"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: I’ve heard you’re making weapons for everyone who fears the darkness. I’d like something for protection, just to be prepared."},
			{"character": "player", "text": "Me: I understand, given the times… I’ll make you a good weapon."},
		],
	},
	
	"quest_second_chapter_30": {
		"quest_id": "quest_second_chapter_30",
		"title": "Find third villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_3',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_30_2"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, let's find last villager."},
		],
	},
	
	"quest_second_chapter_30_2": {
		"quest_id": "quest_second_chapter_30_2",
		"title": "Serve third villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.SELL,
			"customer_id": 'villager_3',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_31"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: I don’t know how this will all end, but I’ll feel better if I have a weapon. Could you help me?"},
			{"character": "player", "text": "Me: Absolutely. I’ll make you a reliable weapon."},
		],
	},
	
	"quest_second_chapter_31": {
		"quest_id": "quest_second_chapter_31",
		"title": "Find the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"recipes": [Inventory.inventory_dictionary["legendarySword"]["id"]],
			"goods": [{
				"item_id": Inventory.inventory_dictionary["magicalPotion"]["id"],
				"qty": 1
			}],
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_32"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh, that is all! Let's go back to the Elder"},
		],
	},
	
	"quest_second_chapter_32": {
		"quest_id": "quest_second_chapter_32",
		"title": "Go to home",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.HOUSE,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_33"],
		"dialog_data": [
			{"character": "king", "text": "Elder: You've helped all those who needed protection. Now it’s time for the final step. Take this magical potion."},
			{"character": "king", "text": "Elder: Combine it with the three artifacts you’ve found, and from this, forge the legendary weapon—the Sword of Light. Only it has the power to defeat the darkness."},
			{"character": "player", "text": "Me: Thank you, Elder. I’ll use everything I have to create this sword."},
		],
	},
	
	"quest_second_chapter_33": {
		"quest_id": "quest_second_chapter_33",
		"title": "Craft legendary sword",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.CRAFT,
			"item_id": Inventory.inventory_dictionary["legendarySword"]["id"],
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_34"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh, let's begin. I have only one try."},
		],
	},

	"quest_second_chapter_34": {
		"quest_id": "quest_second_chapter_34",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_35"],
		"dialog_data": [
			{"character": "player", "text": "Me: Ok, I should say to the Elder that sword is done!"},
		],
	},

	"quest_second_chapter_35": {
		"quest_id": "quest_second_chapter_35",
		"title": "Go to the Evil Caves",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'level-7',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"prerequisites": [
			{"type": "unlock_level", "level_id": "level-7"},
		],
		"next_quests": ["quest_second_chapter_36"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Now that the legendary sword is complete, it’s time to put an end to this darkness. "},
			{"character": "king", "text": "Elder: Go to the depths of the cave. There, you’ll find an ancient altar, designed to seal away evil. Drive the sword into the altar, and the darkness will be bound."},
			{"character": "player", "text": "Me: I’ll do it. Your faith in me gives me strength."},
		],
	},

	"quest_second_chapter_36": {
		"quest_id": "quest_second_chapter_36",
		"title": "Find the Evil Altar",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.ALTAR_EVIL,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_second_chapter_37"],
		"dialog_data": [
			{"character": "player", "text": "Me: It's very dark. I feel I am close to it"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Level-7.tscn",
				"node_name": "/root/level-7/QuestNodes/quest_seal_evil",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},
	
	"quest_second_chapter_37": {
		"quest_id": "quest_second_chapter_37",
		"title": "Return to the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_1"],
		"dialog_data": [
			{"character": "player", "text": "Me: Oh my god! I did it! Evil is sealed!"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Level-7.tscn",
				"node_name": "/root/level-7/QuestNodes/quest_seal_evil",  # Path to the quest node in the scene
				"action": Enums.QuestActions.HIDE,  # Action to perform (e.g., "show", "hide")
			},
			{
				"stage": "res://Stages/Levels/Level-7.tscn",
				"node_name": "/root/level-7/QuestNodes/quest_sealed_evil",  # Path to the quest node in the scene
				"action": Enums.QuestActions.SHOW,  # Action to perform (e.g., "show", "hide")
			},
		],
	},


	"quest_third_chapter_1": {
		"quest_id": "quest_third_chapter_1",
		"title": "Talk with first villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_4',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_2"],
		"dialog_data": [
			{"character": "king", "text": "Elder: You have accomplished a great deed, apprentice. You saved our village and completed what your mentor could not. Now you are a true master."},
			{"character": "king", "text": "Elder: May your name live on in the legends of our village. Thank you."},
			{"character": "player", "text": "Me: Thank you, Elder. It was an honor."},
			{"character": "player", "text": "Me: Ok, I should say this good news to everyone!"},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_villagers_good_news",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},
	
	"quest_third_chapter_2": {
		"quest_id": "quest_third_chapter_2",
		"title": "Talk with second villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_5',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_3"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: Thank you! Because of you, our village is safe."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_villagers_good_news",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},
	
	"quest_third_chapter_3": {
		"quest_id": "quest_third_chapter_3",
		"title": "Talk with third villager",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": 'villager_6',
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_4"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: You’re a hero! We all owe you our lives."},
		],
		"quest_actions": [
			{
				"stage": "res://Stages/Levels/Village.tscn",
				"node_name": "/root/Village/QuestNodes/quest_3_villagers_good_news",
				"action": Enums.QuestActions.SHOW,
			},
		],
	},

	"quest_third_chapter_4": {
		"quest_id": "quest_third_chapter_4",
		"title": "Talk with the Elder",
		"description": "",
		"objectives": [{
			"type": Enums.QuestTypes.VISIT,
			"item_id": Enums.QuestTargetObjects.KING,
			"qty": 1
		}],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_5"],
		"dialog_data": [
			{"character": "villager", "text": "Villager: You’ve banished the darkness! Now we can sleep peacefully."},
		],
	},

	"quest_third_chapter_5": {
		"quest_id": "quest_third_chapter_5",
		"title": "More quests coming!",
		"description": "",
		"objectives": [],
		"rewards": {
			"experience": 5
		},
		"next_quests": ["quest_third_chapter_5"],
		"dialog_data": [
			{"character": "king", "text": "Elder: Thank you, hero! Now you can relax and craft anything you want."},
			{"character": "king", "text": "Elder: Did you learn all recipes?"},
			{"character": "king", "text": "Elder: Continue to improve your skills. Maybe it is not the last time you need it!"},
			{"character": "player", "text": "Me: Yes, I should continue!"},
		],
	},
}


func _ready():
	GlobalSignals.new_game_started.connect(start_timer)
	GlobalSignals.stage_changed.connect(update_quest)
	start_timer()
	#start_quest("quest_second_chapter_35")

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
	var quest_data = null

	# Check if the quest_id exists in the dictionary
	if quest_database.has(quest_id):
		quest_data = quest_database[quest_id]
	else:
		print("Quest ID not found: ", quest_id)
	
	if quest_data != null:
		if quest_data.has("dialog_data"):
			GlobalSignals.start_dialog.emit(quest_data["dialog_data"])
			
		# Process prerequisites
		if quest_data.has("prerequisites"):
			process_prerequisites(quest_data["prerequisites"])
		
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
			objective.customer_id = objective_data["customer_id"] if objective_data.has("customer_id") else "0"

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

func update_objective_progress(type: int, item_id, qty: int):
	print('type ', type, 'item_id ', item_id, 'qty ', qty)
	for quest in active_quests:
		for objective in quest.objectives:
			var target_item_id = str(objective.item_id);
			var item_id_str = str(item_id)
			
			if type == Enums.QuestTypes.COLLECT and objective.type == Enums.QuestTypes.COLLECT and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.VISIT and objective.type == Enums.QuestTypes.VISIT and target_item_id == item_id_str:
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.CRAFT and objective.type == Enums.QuestTypes.CRAFT and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)
				
			if type == Enums.QuestTypes.BUY and objective.type == Enums.QuestTypes.BUY and int(target_item_id) == int(item_id):
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.SELL and objective.type == Enums.QuestTypes.SELL:
				do_progress(objective, qty, quest)

			if type == Enums.QuestTypes.SELL_TO_KING and objective.type == Enums.QuestTypes.SELL_TO_KING:
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
	print('process_quest_actions', quest_phase, " ", actions_array)
	var current_stage_path = SceneManager.get_current_scene_path()
	print("current_stage_path", current_stage_path)
	for action_data in actions_array:
		var action_stage = action_data.get("stage", "")
		var node_name = action_data.get("node_name", "")
		var action = action_data.get("action", "")

		# Check if the action's stage matches the current stage
		if action_stage.to_lower() != current_stage_path.to_lower():
			continue  # Skip actions not related to the current stage

		# Determine if the action should be processed during the quest phase
		if quest_phase == "start" and action == Enums.QuestActions.SHOW:
			update_quest_node(node_name, Enums.QuestActions.SHOW)
		elif quest_phase == "complete" and action == Enums.QuestActions.HIDE:
			update_quest_node(node_name, Enums.QuestActions.HIDE)
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
		if action == Enums.QuestActions.SHOW:
			quest_node.visible = true
			#enable_collision(quest_node, true)
		elif action == Enums.QuestActions.HIDE:
			quest_node.visible = false
			#enable_collision(quest_node, false)
		elif action == Enums.QuestActions.REMOVE:
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

func process_prerequisites(prerequisites):
	for prerequisite in prerequisites:
		var prereq_type = prerequisite["type"]
		if prereq_type == "unlock_level":
			var level_id = prerequisite["level_id"]
			GameState.unlock_level(level_id)
			print("Unlocked level: ", level_id)
		if prereq_type == "unlock_recipes":
			for recipe_id in prerequisite["recipes"]:
				Inventory.unlock_recipe(recipe_id)
				print("Unlocked recipe for item ID:", recipe_id)
		#elif prereq_type == "give_item":
		#	var item_id = prerequisite["item_id"]
		#	var qty = prerequisite["qty"]
		#	Inventory.add_item(item_id, qty)
		#	print("Gave player item: ", item_id, " x", qty)
		else:
			print("Unknown prerequisite type: ", prereq_type)
