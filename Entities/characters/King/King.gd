extends Node2D

var speed: int = 20  # Speed at which the villager moves
@onready var panel = $VillagerUi
@onready var sprite = $AnimatedSprite2D
var wishFromQuest = null
var reward = null
@export var direction: int = 1

func _ready():
	panel.visible = false
	
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	sprite.play("idle")

func generate_wish():
	wishFromQuest = null;
	
	for quest in QuestManager.active_quests:
		for objective in quest.objectives:
			if objective.type == Enums.QuestTypes.SELL_TO_KING:
				print('objective ', objective)
				wishFromQuest = Inventory.find_dictionary_item_by_id(int(objective["item_id"]))
				wishFromQuest["qty"] = objective.target_qty
				
				reward = Inventory.find_dictionary_item_by_id(quest["rewards"]["goods"][0]["item_id"])
				reward["qty"] = quest["rewards"]["goods"][0]["qty"]
				break

	if wishFromQuest:
		update_wish_panel(wishFromQuest, reward)

func update_wish_panel(wishData, rewardData) -> void:
	var wish_slot = panel.get_node("ColorRect/MarginContainer/VBoxContainer/HBoxContainer/InventorySlotWanted")
	var reward_slot = panel.get_node("ColorRect/MarginContainer/VBoxContainer/HBoxContainer/InventorySlotReward")

	wish_slot.set_item({
		"texture": wishData['texture'],
		"qty": wishData["qty"],
		"name": wishData['name'],
		"type": wishData['type']
	})
	
	reward_slot.set_item({
		"texture": rewardData['texture'],
		"qty": rewardData["qty"],
		"name": rewardData['name'],
		"type": rewardData['type']
	})


func _on_villager_ui_button_pressed():
	if wishFromQuest and Inventory.has_enough_resources([wishFromQuest]):
		print('sell to king')
		Inventory.add_item(reward.id, reward.qty)
		Inventory.remove_items([wishFromQuest])
		QuestManager.update_objective_progress(Enums.QuestTypes.SELL_TO_KING, str(wishFromQuest.id), wishFromQuest.qty)
		
		wishFromQuest = null
		close_wish_panel()

func open_wish_panel():
	panel.visible = true

func close_wish_panel():
	panel.visible = false

func _on_area_2d_2_area_entered(area):
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, "king", 1)
	generate_wish()
	
	var panelButton = panel.find_child('Button')

	panelButton.disabled = true

	if wishFromQuest and Inventory.has_enough_resources([wishFromQuest]):
		panelButton.disabled = false

	if area.get_parent() is Player and wishFromQuest:
		open_wish_panel()


func _on_area_2d_2_area_exited(area):
	if area.get_parent() is Player:
		close_wish_panel()
