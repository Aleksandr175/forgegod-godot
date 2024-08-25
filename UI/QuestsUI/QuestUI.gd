extends Control

@onready var quest_list = $QuestList  # A VBoxContainer or similar

@onready var quest_name = $ColorRect/quest_name
@onready var quest_description = $ColorRect/quest_description
@onready var quest_progress = $ColorRect/quest_progress
@onready var quest_requirement = $ColorRect/quest_requirement

func _ready():
	print('quest UI ready')

func clear_quests():
	quest_name.text = ''
	quest_description.text = ''
	quest_progress.text = ''
	quest_requirement.text = ''
	#quest_list.clear_children()  # Clear existing quest list

func add_quest(title: String, description: String, objectives: Array):
	print('add quest', title, description)
	quest_name.text = title
	quest_description.text = description
	#quest_list.add_child(quest_label)

	for objective in objectives:
		print('objective', objective)
	#	pass
		#var objective_label = Label.new()
		#objective_label.text = objective.description + " (" + str(objective.current_amount) + "/" + str(objective.target_amount) + ")"
		#quest_list.add_child(objective_label)
		#quest_progress.text = '0/' + objective.qty
	#	quest_requirement.text = objective.description

