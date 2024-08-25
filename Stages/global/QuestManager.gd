extends Node

var experience = 10
@onready var XPValue = $CanvasLayer/XPValue
@onready var quest_ui = $CanvasLayer/QuestUi

enum QuestStatus {
	available,
	started,
	in_progress,
	finished
}

@onready var quest_log_ui: Control = %QuestUI  # Reference to the UI element for the quest log
var active_quests: Array = []
var completed_quests: Array = []
var quest_database = {
	"quest_1": {
		"title": "Need some money",
		"description": "Collect 3 coins.",
		"objectives": [{
			"description": "Collect 3 coins",
			"type": "collect",
			"resource": "coin",
			"qty": 3
		}],
		"rewards": {"coins": 50, "experience": 10},
		"prerequisites": [],
		"next_quests": ["quest_2"]
	},
	"quest_2": {
		"title": "Sword time",
		"description": "Craft Copper Sword.",
		"objectives": [{
			"description": "Craft",
			"type": "craft",
			"item": "swordCopper",
			"qty": 1
		}],
		"rewards": {"coins": 100, "experience": 20},
		"prerequisites": ["quest_1"],
		"next_quests": ["quest_3"]
	},
	"quest_3": {
		"title": "Advanced Blacksmithing",
		"description": "Craft an Iron Sword and a Copper Shield.",
		"objectives": [{
			"type": "craft",
			"item": "swordIron",
			"qty": 1
		}],
		"rewards": {"coins": 150, "experience": 30},
		"prerequisites": ["quest_1", "quest_2"],
		"next_quests": []
	}
}


func _ready():
	print(quest_ui)
	start_quest('quest_1')
	pass


#func _initialize_quest_log_ui():
#	quest_log_ui = get_tree().get_root().get_node("Entities/players/QuestUI")  # Adjust the path as necessary
#	if QuestUI:
#		update_quest_ui()
#		#quest_log_ui = get_node("QuestUI")
#		print('QuestUI', QuestUI)
#		start_quest("quest_1")
#		update_quest_ui()
#	else:
#		print("QuestLogUI not found, trying again...")
	
func start_quest(quest_id: String):	
	var quest_data = quest_database[quest_id]
	
	if quest_data != null:
		# Check if prerequisites are completed
		for prereq in quest_data["prerequisites"]:
			if !completed_quests.has(prereq):
				print("Cannot start quest: ", quest_id, ". Prerequisite quest not completed: ", prereq)
				return
		
		# If all prerequisites are completed, start the quest
		var new_quest = Quest.new()
		new_quest.title = quest_data["title"]
		new_quest.description = quest_data["description"]
		new_quest.rewards = quest_data["rewards"]
		new_quest.status = "In Progress"
		
		for objective_data in quest_data["objectives"]:
			var objective = Objective.new()
			objective.description = objective_data.description
			objective.target_amount = objective_data.qty
			# Further customize based on objective type (craft, collect, visit, etc.)
			new_quest.objectives.append(objective)
		
		active_quests.append(new_quest)
		print("Quest started: ", new_quest.title)
		update_quest_ui()

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
		print("Quest completed: ", quest.title)
		
		# Start next quests
		for next_quest_id in quest_database[quest.title]["next_quests"]:
			start_quest(next_quest_id)

func update_quest_ui():
	if quest_ui:
		quest_ui.clear_quests()
		for quest in active_quests:
			print('add quest', quest)
			quest_ui.add_quest(quest.title, quest.description, quest.objectives)
#func update_quest_log_ui():
#	var quest_log = get_node("QuestUI")
#	quest_log.clear()
	
#	for quest in active_quests:
#		quest_log.add_text(quest.title + ": " + quest.description)
#		for objective in quest.objectives:
#			quest_log.add_text(" - " + objective.description + ": " + str(objective.current_amount) + "/" + str(objective.target_amount))
