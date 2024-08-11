extends Control

@onready var inventory_container = $VBoxContainer/HBoxContainer/ScrollContainer/inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

func _on_inventory_updated():
	clear_grid_container()
	# Add slots for each inventory position
	for item in Inventory.inventory_items:
		var slot = Inventory.inventory_slot_scene.instantiate()
		inventory_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()
	
func clear_grid_container():
	while inventory_container.get_child_count() > 0:
		var child = inventory_container.get_child(0)
		inventory_container.remove_child(child)
		child.queue_free()
