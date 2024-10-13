extends Control
class_name RecipesUI

@onready var recipes_container = $VBoxContainer/ScrollContainer/GridContainer

signal recipe_ui_slot_selected(recipe)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inventory.inventory_updated.connect(_on_recipes_updated)
	_on_recipes_updated()

func _on_recipes_updated():
	clear_grid_container()
	# Add slots for each recipe position
	for item in Inventory.recipes:
		var slot = Inventory.recipe_slot_scene.instantiate()
		recipes_container.add_child(slot)
		if item != null:
			slot.set_item(item)
			# Connect the inventory_slot_selected signal from each slot
			slot.recipe_slot_selected.connect(_on_recipe_slot_selected)
		else:
			slot.set_empty()
	
func clear_grid_container():
	while recipes_container.get_child_count() > 0:
		var child = recipes_container.get_child(0)
		recipes_container.remove_child(child)
		child.queue_free()
		#print('clear_grid_container', recipes_container.get_child_count())

# Callback function that handles the slot selection
func _on_recipe_slot_selected(recipe):
	#print("Recipe selected!", recipe)
	# Emit the signal to notify other parts of your game
	emit_signal("recipe_ui_slot_selected", recipe)
