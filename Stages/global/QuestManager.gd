extends Node

var experience = 10
#@onready var XPValue = $CanvasLayer/XPValue
#@onready var quest_ui = $CanvasLayer/QuestUi
#@onready var ui = $CanvasLayer;

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
		"rewards": {"coins": 50, "experience": 10},
		"prerequisites": [],
		"next_quests": ["quest_2"]
	},
	"quest_2": {
		"quest_id": "quest_2",
		"title": "Sword time",
		"description": "Craft Copper Sword.",
		"objectives": [{
			"description": "Craft",
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["swordCopper"]["id"],
			"qty": 1
		}],
		"rewards": {"coins": 100, "experience": 20},
		"prerequisites": ["quest_1"],
		"next_quests": ["quest_3"]
	},
	"quest_3": {
		"quest_id": "quest_3",
		"title": "Advanced Blacksmithing",
		"description": "Craft an Iron Sword and a Copper Shield.",
		"objectives": [{
			"type": "craft",
			"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
			"qty": 1
		}],
		"rewards": {"coins": 150, "experience": 30},
		"prerequisites": ["quest_1", "quest_2"],
		"next_quests": []
	}
}

func _ready():
#	print(quest_ui)
#	print('ui',ui)
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", _initialize_ui)
	timer.start()

func _initialize_ui():
	start_quest('quest_1')

	
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
			objective.description = objective_data.description
			objective.target_qty = objective_data.qty
			objective.item_id = objective_data.item_id
			objective.type = objective_data.type

			new_quest.objectives.append(objective)
		
		active_quests.append(new_quest)
		print("Quest started: ", new_quest.title)
		update_quest()

func check_objectives(quest: Quest) -> bool:
	for objective in quest.objectives:
		if not objective.is_completed():
			return false
	return true
	
func distribute_rewards(rewards: Dictionary):
	# Handle giving the player their rewards, e.g., adding items to inventory
	for key in rewards.keys():
		# Add logic to give the player their reward
		print("Received reward: ", key, "x", rewards[key])

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
	print('update_quest_ui', active_quests)
	update_quest_ui.emit(active_quests)

func update_objective_progress(item_id: int, qty: int):
	print('item_id', item_id, 'qty', qty)
	print('active_quests', active_quests)
	for quest in active_quests:
		for objective in quest.objectives:
			print(objective.description, objective.target_qty, objective.current_qty, objective.type)
			if objective.type == "collect" and objective.item_id == item_id:
				objective.progress(qty)
				update_quest()
				if objective.is_completed():
					print("Objective completed: ", objective.description)
					complete_quest(quest)
				emit_signal("quest_updated", quest)