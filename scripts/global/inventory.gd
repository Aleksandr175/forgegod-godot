extends Node2D

var inventory_items = []
var recipes = [{
	"id": "sword",
	"name": "Sword",
	"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
	"qty": "1",
	"requirements": [{
		"id": "iron",
		"qty": "2"
	}],
	"type": "recipe"
}, {
	"id": "sword2",
	"name": "Sword Copper",
	"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
	"qty": "1",
	"requirements": [{
		"id": "copper",
		"qty": "2"
	}],
	"type": "recipe"
}]

signal inventory_updated

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene = preload("res://scenes/ui/Inventory_Slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_items.resize(10)
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
	
func remove_item():
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player
