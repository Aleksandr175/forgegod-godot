extends Node2D

var inventoryItems = []

signal inventory_updated

# Scene and node references
var player_node: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	inventoryItems.resize(30)
	pass # Replace with function body.

func add_item(new_item):
	var item_found = false	

	# Loop through inventory to find the item by name
	for item in inventoryItems:
		if item and item.name == new_item.name:
			# Item found, increase quantity
			item.qty += new_item.qty
			item_found = true
			break

	if not item_found:
		# Item not found, add new item to inventory
		inventoryItems.append(new_item)

	print('inventoryItems',inventoryItems)
	# Emit signal after adding/updating the item
	inventory_updated.emit()
	
func remove_item():
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player
