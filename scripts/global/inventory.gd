extends Node2D

var inventory_size = 20

var inventory_dictionary = {
	"coin": {
		"id": 1,
		"name": "Coin",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/coin.png"),
		"value": 1,
	},
	"iron": {
		"id": 2,
		"name": "Iron Sword",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
		"value": 3,
	},
	"copper": {
		"id": 3,
		"name": "Copper Sword",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
		"value": 5
	},
}

var inventory_items = [{
	"id": inventory_dictionary["coin"]["id"], 
	"qty": 50, 
	"name": inventory_dictionary["coin"]["name"], 
	"type": inventory_dictionary["coin"]["type"], 
	"texture": inventory_dictionary["coin"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}, { 
	"id": inventory_dictionary["iron"]["id"], 
	"qty": 5, 
	"name": inventory_dictionary["iron"]["name"], 
	"type": inventory_dictionary["iron"]["type"], 
	"texture": inventory_dictionary["iron"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
},{ 
	"id": inventory_dictionary["copper"]["id"], 
	"qty": 20, 
	"name": inventory_dictionary["copper"]["name"], 
	"type": inventory_dictionary["copper"]["type"], 
	"texture": inventory_dictionary["copper"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}]

var shop_items = [{
	"id": inventory_dictionary["iron"]["id"],
	"name": inventory_dictionary["iron"]["name"],
	"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
	"price": 10,
	"type": "Resource"
}, {
	"id": inventory_dictionary["copper"]["id"],
	"name": inventory_dictionary["copper"]["name"],
	"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
	"price": 15,
	"type": "Resource",
}]

var recipes = [{
	"id": 1,
	"name": "Iron Sword",
	"texture": load("res://assets/sprites/objects/goods/swordIron.png"),
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["iron"]["id"], 
		"name": inventory_dictionary["iron"]["name"], 
		"type": inventory_dictionary["iron"]["type"], 
		"texture": inventory_dictionary["iron"]["texture"],
		"qty": 5,
	}],
}, {
	"id": 2,
	"name": "Sword Copper",
	"texture": load("res://assets/sprites/objects/goods/swordCopper.png"),
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["copper"]["id"], 
		"name": inventory_dictionary["copper"]["name"], 
		"type": inventory_dictionary["copper"]["type"], 
		"texture": inventory_dictionary["copper"]["texture"],
		"qty": 3,
	}],
}]

signal inventory_updated

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene = preload("res://scenes/ui/Inventory_Slot.tscn")
@onready var recipe_slot_scene = preload("res://scenes/ui/Recipe_Slot.tscn")
@onready var shop_slot_scene = preload("res://scenes/ui/Shop_Slot.tscn")
@onready var inventory_slot_small_scene = preload("res://scenes/ui/Inventory_Slot_Small.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_items.resize(inventory_size)
	pass # Replace with function body.

func add_item(new_item):
	var item_found = false

	# Check if the item already exists in the inventory
	for i in range(inventory_items.size()):
		var item = inventory_items[i]
		if item != null and item.name == new_item.name:
			# Item found, increase quantity
			item.qty += new_item.qty
			inventory_items[i] = item
			item_found = true
			break

	# If item was not found, find the first empty slot to add the new item
	if not item_found:
		for i in range(inventory_items.size()):
			if inventory_items[i] == null:
				inventory_items[i] = new_item
				item_found = true
				break

	print('inventory_items', inventory_items)
	# Emit signal after adding/updating the item
	inventory_updated.emit()
	
func remove_item(item):
	for i in range(inventory_items.size()):
		var inventory_item = inventory_items[i]

		if inventory_item and inventory_item.id == item.id:
			inventory_item.qty -= int(item.qty)
			if inventory_item.qty <= 0:
				# mark inventory item as empty
				inventory_items[i] = null
			break

	inventory_updated.emit()

func set_player_reference(player):
	player_node = player
	
func has_required_items(requirements):
	for requirement in requirements:
		var found = false
		# Check if the inventory contains the required item with sufficient quantity
		for inventory_item in Inventory.inventory_items:
			if inventory_item and inventory_item.name == requirement.name and int(inventory_item.qty) >= int(requirement.qty):
				found = true
				break
		# If any requirement is not met, return false
		if not found:
			return false
	return true

func remove_items(items):
	# Reduce the quantity of each required item from the inventory
	for item in items:
		Inventory.remove_item(item)

func find_item_by_id(item):
	for inventory_item in Inventory.inventory_dictionary:
		if inventory_item.id == item.id:
			return inventory_item
	return null
	
func find_item_in_inventory(item):
	for inventory_item in Inventory.inventory_items:
		if inventory_item and inventory_item.id == item.id:
			return inventory_item
	return null
	
func has_enought_coins(needed: int):
	var coins = find_item_in_inventory(Inventory.inventory_dictionary["coin"])
	return coins and coins.qty >= needed
