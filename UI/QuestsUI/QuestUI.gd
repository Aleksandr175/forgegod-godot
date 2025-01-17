extends Control

#@onready var quest_list = $QuestList  # A VBoxContainer or similar

@onready var quest_name = $ColorRect/MarginContainer/VBoxContainer/quest_name
@onready var quest_description = $ColorRect/MarginContainer/VBoxContainer/quest_description
@onready var quest_progress = $ColorRect/MarginContainer/VBoxContainer/quest_progress

func _ready():
	QuestManager.connect("update_quest_ui", _on_quest_manager_update_quest_ui)

func clear_quests():
	quest_name.text = ''
	quest_description.text = ''
	quest_progress.text = ''
	#quest_list.clear_children()  # Clear existing quest list

func add_quest(title: String, description: String, objectives: Array):
	print('add quest', title, description)
	quest_name.text = title
	quest_description.text = description
	#quest_list.add_child(quest_label)

	for objective in objectives:
		#print('objective', objective.description, objective.target_qty)
	#	pass
		#var objective_label = Label.new()
		#objective_label.text = objective.description + " (" + str(objective.current_amount) + "/" + str(objective.target_amount) + ")"
		#quest_list.add_child(objective_label)
		if objective.type == Enums.QuestTypes.CRAFT or objective.type == Enums.QuestTypes.COLLECT or objective.type == Enums.QuestTypes.BUY or objective.type == Enums.QuestTypes.SELL:
			quest_progress.text = str(objective.current_qty) + '/' + str(objective.target_qty)
		else:
			quest_progress.text = ''

func _on_quest_manager_update_quest_ui(active_quests):
	clear_quests()
	for quest in active_quests:
		add_quest(quest.title, quest.description, quest.objectives)

func _on_tree_exited():
	QuestManager.disconnect("update_quest_ui", _on_quest_manager_update_quest_ui)
