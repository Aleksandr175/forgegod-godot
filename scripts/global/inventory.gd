extends Node2D

var inventory_items = [{ 
	"qty": 5, 
	"name": "Iron", 
	"type": "Resource", 
	"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
},{ 
	"qty": 20, 
	"name": "Copper", 
	"type": "Resource", 
	"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}]

var inventory_size = 8
var recipes = [{
	"id": "sword",
	"name": "Sword",
	"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
	"qty": "1",
	"requirements": [{
		"id": "iron",
		"name": "Iron",
		"qty": "5",
		"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
		"type": "resource",
	}],
	"type": "recipe"
}, {
	"id": "sword2",
	"name": "Sword Copper",
	"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
	"qty": "1",
	"requirements": [{
		"id": "copper",
		"name": "Copper",
		"qty": "3",
		"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
		"type": "resource",
	}],
	"type": "recipe"
}]

signal inventory_updated

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene = preload("res://scenes/ui/Inventory_Slot.tscn")
@onready var recipe_slot_scene = preload("res://scenes/ui/Recipe_Slot.tscn")
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

		if inventory_item.name == item.name:
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
