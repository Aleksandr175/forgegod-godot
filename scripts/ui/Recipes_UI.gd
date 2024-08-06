extends Control

@onready var recipes_container = $VBoxContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#Inventory.inventory_updated.connect(_on_recipes_updated)
	_on_recipes_updated()
	
func _on_recipes_updated():
	clear_grid_container()
	# Add slots for each recipe position
	for item in Inventory.recipes:
		var slot = Inventory.inventory_slot_scene.instantiate()
		recipes_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()
	
func clear_grid_container():
	while recipes_container.get_child_count() > 0:
		var child = recipes_container.get_child(0)
		recipes_container.remove_child(child)
		child.queue_free()
