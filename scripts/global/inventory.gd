extends Node2D

var inventory_size = 20

var inventory_dictionary: Dictionary = {
	"coin": {
		"id": 1,
		"name": "Coin",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/coin.png"),
		"value": 1,
	},
	"wood": {
		"id": 2,
		"name": "Wood",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-wood.png"),
		"value": 3,
	},
	"iron": {
		"id": 3,
		"name": "Iron",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
		"value": 3,
	},
	"copper": {
		"id": 4,
		"name": "Copper",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
		"value": 5
	},

	"swordWooden": {
		"id": 100,
		"name": "Wooden Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/swordWooden.png"),
		"value": 15
	},
	"swordIron": {
		"id": 101,
		"name": "Iron Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/swordIron.png"),
		"value": 10,
	},
	"swordCopper": {
		"id": 102,
		"name": "Copper Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/swordCopper.png"),
		"value": 10,
	},

	"axWooden": {
		"id": 110,
		"name": "Wooden Ax",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/axWooden.png"),
		"value": 15
	},
	"axIron": {
		"id": 111,
		"name": "Iron Ax",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/axIron.png"),
		"value": 10,
	},

	"spearWooden": {
		"id": 120,
		"name": "Wooden Spear",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/spearWooden.png"),
		"value": 15
	},
	"spearIron": {
		"id": 121,
		"name": "Iron Spear",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/spearIron.png"),
		"value": 10,
	},
}

var inventory_items: Array = [{
	"id": inventory_dictionary["coin"]["id"], 
	"qty": 50, 
	"name": inventory_dictionary["coin"]["name"], 
	"type": inventory_dictionary["coin"]["type"], 
	"texture": inventory_dictionary["coin"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}, {
	"id": inventory_dictionary["swordIron"]["id"], 
	"qty": 50, 
	"name": inventory_dictionary["swordIron"]["name"], 
	"type": inventory_dictionary["swordIron"]["type"], 
	"texture": inventory_dictionary["swordIron"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}, {
	"id": inventory_dictionary["swordWooden"]["id"], 
	"qty": 10, 
	"name": inventory_dictionary["swordWooden"]["name"], 
	"type": inventory_dictionary["swordWooden"]["type"], 
	"texture": inventory_dictionary["swordWooden"]["texture"],
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

var shop_items: Array = [{
	"id": inventory_dictionary["wood"]["id"],
	"name": inventory_dictionary["wood"]["name"],
	"texture": inventory_dictionary["wood"]["texture"],
	"price": 10,
	"type": "Resource"
}, {
	"id": inventory_dictionary["iron"]["id"],
	"name": inventory_dictionary["iron"]["name"],
	"texture": inventory_dictionary["iron"]["texture"],
	"price": 10,
	"type": "Resource"
}, {
	"id": inventory_dictionary["copper"]["id"],
	"name": inventory_dictionary["copper"]["name"],
	"texture": inventory_dictionary["copper"]["texture"],
	"price": 15,
	"type": "Resource",
}]

var recipes: Array = [{
	"id": inventory_dictionary["swordIron"]["id"],
	"name": inventory_dictionary["swordIron"]["name"],
	"texture": inventory_dictionary["swordIron"]["texture"],
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
	"id": inventory_dictionary["swordWooden"]["id"],
	"name": inventory_dictionary["swordWooden"]["name"],
	"texture": inventory_dictionary["swordWooden"]["texture"],
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 3,
	}],
}, {
	"id": inventory_dictionary["swordCopper"]["id"],
	"name": inventory_dictionary["swordCopper"]["name"],
	"texture": inventory_dictionary["swordCopper"]["texture"],
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["copper"]["id"], 
		"name": inventory_dictionary["copper"]["name"], 
		"type": inventory_dictionary["copper"]["type"], 
		"texture": inventory_dictionary["copper"]["texture"],
		"qty": 3,
	}],
}, {
	"id": inventory_dictionary["axWooden"]["id"],
	"name": inventory_dictionary["axWooden"]["name"],
	"texture": inventory_dictionary["axWooden"]["texture"],
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 3,
	}],
}, {
	"id": inventory_dictionary["axIron"]["id"],
	"name": inventory_dictionary["axIron"]["name"],
	"texture": inventory_dictionary["axIron"]["texture"],
	"qty": 1,
	"type": "recipe",
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 3,
	}, {
		"id": inventory_dictionary["iron"]["id"], 
		"name": inventory_dictionary["iron"]["name"], 
		"type": inventory_dictionary["iron"]["type"], 
		"texture": inventory_dictionary["iron"]["texture"],
		"qty": 1,
	}],
},]

signal inventory_updated

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene: PackedScene = preload("res://UI/InventoryUI/Inventory_Slot.tscn")
@onready var recipe_slot_scene: PackedScene = preload("res://UI/RecipesUI/Recipe_Slot.tscn")
@onready var shop_slot_scene: PackedScene = preload("res://UI/ShopUI/Shop_Slot.tscn")
@onready var inventory_slot_small_scene: PackedScene = preload("res://UI/InventoryUI/Inventory_Slot_Small.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_items.resize(inventory_size)
	pass # Replace with function body.

func add_item(item_id: int, qty: int) -> void:
	var item_dictionary = find_dictionary_item_by_id(item_id)
	var item_found = false

	# Check if the item already exists in the inventory
	for i in range(inventory_items.size()):
		var item = inventory_items[i]
		if item != null and item.id == item_dictionary.id:
			# Item found, increase quantity
			item.qty += qty
			inventory_items[i] = item
			item_found = true
			break

	# If item was not found, find the first empty slot to add the new item
	if not item_found:
		for i in range(inventory_items.size()):
			if inventory_items[i] == null:
				inventory_items[i] = item_dictionary
				inventory_items[i].qty = qty
				item_found = true
				break

	#print('inventory_items', inventory_items)
	# Emit signal after adding/updating the item
	inventory_updated.emit()
	
func remove_item(item: Dictionary) -> void:
	for i in range(inventory_items.size()):
		var inventory_item = inventory_items[i]

		#print('-------', inventory_item, item)
		if inventory_item and inventory_item.id == item.id:
			inventory_item.qty -= int(item.qty)
			if inventory_item.qty <= 0:
				# mark inventory item as empty
				inventory_items[i] = null
			break

	inventory_updated.emit()

func set_player_reference(player: Node) -> void:
	player_node = player
	
func has_required_items(requirements: Array) -> bool:
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

func remove_items(items: Array) -> void:
	# Reduce the quantity of each required item from the inventory
	for item in items:
		Inventory.remove_item(item)

func find_dictionary_item_by_id(itemId: int):
	for inventory_item in Inventory.inventory_dictionary:
		print(inventory_item, Inventory.inventory_dictionary[inventory_item], itemId)
		if Inventory.inventory_dictionary[inventory_item]["id"] == itemId:
			return Inventory.inventory_dictionary[inventory_item]
	return null

func find_dictionary_item_by_name(item_name: String):
	for inventory_item in Inventory.inventory_dictionary:
		if Inventory.inventory_dictionary[inventory_item]["name"] == item_name:
			return Inventory.inventory_dictionary[inventory_item]
	return null
	
func find_item_in_inventory(item):
	for inventory_item in Inventory.inventory_items:
		if inventory_item and inventory_item.id == item.id:
			return inventory_item
	return null

func has_enought_coins(needed: int) -> bool:
	var coins = find_item_in_inventory(Inventory.inventory_dictionary["coin"])
	return coins and coins.qty >= needed

func has_enough_resources(resources: Array) -> bool:
	var enough_resources = true

	for resource in resources:
		var resource_in_inventory = find_item_in_inventory(resource)
		var qty = 0

		if resource_in_inventory != null:
			qty = resource_in_inventory.qty

		if qty < resource.qty:
			enough_resources = false
			break

	return enough_resources
