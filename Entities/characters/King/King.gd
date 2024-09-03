extends Node2D

var speed: int = 20  # Speed at which the villager moves
@onready var panel = $VillagerUi
@onready var sprite = $AnimatedSprite2D
var wish = null
var reward = null
@export var direction: int = 1

func _ready():
	panel.visible = false
	generate_wish()
	
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	sprite.play("idle")

func generate_wish():
	var possible_wishes = Inventory.recipes
	wish = possible_wishes[randi() % possible_wishes.size()]
	# villager wants to buy only 1 item
	wish.qty = 1
	
	var wishItem = Inventory.find_dictionary_item_by_id(wish.id)
	
	reward = {
		"id": Inventory.inventory_dictionary["coin"]["id"],
		"name": Inventory.inventory_dictionary["coin"]["name"],
		"texture": Inventory.inventory_dictionary["coin"]["texture"],
		"type": Inventory.inventory_dictionary["coin"]["type"],
		"qty": wishItem.value,
	}

	update_wish_panel(wish, reward)

func update_wish_panel(wishData, rewardData):
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
	if wish and Inventory.has_enough_resources([wish]):
		Inventory.add_item(reward.id, reward.qty)
		Inventory.remove_items([wish])
		QuestManager.update_objective_progress("sell", str(wish.id), 1)
		
		wish = null
		close_wish_panel()

func open_wish_panel():
	panel.visible = true

func close_wish_panel():
	panel.visible = false


func _on_villager_ui_2_button_pressed():
	if wish and Inventory.has_enough_resources([wish]):
		Inventory.add_item(reward.id, reward.qty)
		Inventory.remove_items([wish])
		QuestManager.update_objective_progress("king", str(wish.id), 1)
		
		wish = null
		generate_next_wish()
		close_wish_panel()
	print('sell to king')
	pass # Replace with function body.

func generate_next_wish():
	print('generate next wish')
	pass

func _on_area_2d_2_area_entered(area):
	if area.get_parent() is Player and wish:
		var active_quests = QuestManager.active_quests
		for quest in active_quests:
			for objective in quest.objectives:
				if objective.type == 'king':
					open_wish_panel()


func _on_area_2d_2_area_exited(area):
	if area.get_parent() is Player:
		close_wish_panel()
