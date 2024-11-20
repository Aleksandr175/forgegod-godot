extends Node2D

var speed: int = 20  # Speed at which the villager moves
@onready var panel = $VillagerUi
@onready var sprite_villager = $AnimatedSprite2DCustomer
@onready var sprite_soldier = $AnimatedSprite2DSoldier
var wishFromQuest = null
var reward = null
@export var customer_type: String = "villager"
@export var direction: int = 1
@export var customer_id: String = ""
@export var sprite_frames: SpriteFrames

var customer_wishes = {
	"customer_1": {
		"item_id": Inventory.inventory_dictionary["axeWooden"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 10
		}
	},
	"customer_2": {
		"item_id": Inventory.inventory_dictionary["spearIron"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 12
		}
	},
	"customer_3": {
		"item_id": Inventory.inventory_dictionary["swordIron"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 15
		}
	},

	"customer_second_chapter_3": {
		"item_id": Inventory.inventory_dictionary["spearEmerald"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 20
		}
	},

	"customer_second_chapter_4": {
		"item_id": Inventory.inventory_dictionary["maceEmerald"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 25
		}
	},

	"customer_second_chapter_5": {
		"item_id": Inventory.inventory_dictionary["staffEmerald"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 30
		}
	},

	"soldier_1": {
		"item_id": Inventory.inventory_dictionary["broadswordIron"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 50
		}
	},
	"soldier_2": {
		"item_id": Inventory.inventory_dictionary["doubleBitAxeSteel"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 100
		}
	},
	"soldier_3": {
		"item_id": Inventory.inventory_dictionary["twilightiteSword"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 200
		}
	},
	
	
	"villager_1": {
		"item_id": Inventory.inventory_dictionary["axeIron"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 20
		}
	},
	"villager_2": {
		"item_id": Inventory.inventory_dictionary["maceEmerald"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 80
		}
	},
	"villager_3": {
		"item_id": Inventory.inventory_dictionary["twilightiteSword"]["id"],
		"qty": 1,
		"reward": {
			"item_id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": 200
		}
	},
}

func _ready():
	panel.visible = false
	
	if direction == 1:
		sprite_villager.flip_h = true
		sprite_soldier.flip_h = true
	else:
		sprite_villager.flip_h = false
		sprite_soldier.flip_h = false

	sprite_villager.visible = false
	sprite_soldier.visible = false

	if customer_type == "villager":
		sprite_villager.visible = true
		sprite_villager.play("idle")

	if customer_type == "soldier":
		sprite_soldier.visible = true
		sprite_soldier.play("idle")

func generate_wish():
	wishFromQuest = null
	reward = null
	
	if customer_id != "" and customer_wishes.has(customer_id):
			
		for quest in QuestManager.active_quests:
			for objective in quest.objectives:
				if objective.type == Enums.QuestTypes.SELL and objective.customer_id == customer_id:
					var wish_data = customer_wishes[customer_id]
					# Fetch the wished item data
					wishFromQuest = Inventory.find_dictionary_item_by_id(wish_data["item_id"])
					wishFromQuest["qty"] = wish_data["qty"]

					# Fetch the reward data
					var reward_data = wish_data["reward"]
					reward = Inventory.find_dictionary_item_by_id(reward_data["item_id"])
					reward["qty"] = reward_data["qty"]

					update_wish_panel(wishFromQuest, reward)
		
	else:
		print("No wish found for customer_id:", customer_id)
	
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
		Inventory.add_item(reward.id, reward.qty)
		Inventory.remove_items([wishFromQuest])
		QuestManager.update_objective_progress(Enums.QuestTypes.SELL, str(wishFromQuest.id), wishFromQuest.qty)

		wishFromQuest = null
		close_wish_panel()

func open_wish_panel():
	panel.visible = true

func close_wish_panel():
	panel.visible = false

func _on_area_2d_2_area_entered(area):
	QuestManager.update_objective_progress(Enums.QuestTypes.VISIT, customer_id, 1)

	if (area.get_parent() is Player or area.get_parent() is PlayerHouse):
		generate_wish()
		
		var panelButton = panel.find_child('Button')

		panelButton.disabled = true

		if wishFromQuest and Inventory.has_enough_resources([wishFromQuest]):
			panelButton.disabled = false

		if wishFromQuest:
			open_wish_panel()

func _on_area_2d_2_area_exited(area):
	if area.get_parent() is Player or area.get_parent() is PlayerHouse:
		close_wish_panel()
