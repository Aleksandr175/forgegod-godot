extends Control


var selected_recipe = null
@onready var recipe_image_container = $VBoxContainer/HBoxContainer/RecipeImageContainer
@onready var recipe_requirements_container = $VBoxContainer/HBoxContainer/VBoxContainer/GridRequirements

# Called when the node enters the scene tree for the first time.
func _ready():
	#InventorySlot.invetory_slot_selected.connect(_on_selected_recipe_updated)
	selected_recipe = Inventory.recipes[0]
	clear_grid_container()
	_on_selected_recipe_updated(selected_recipe)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_selected_recipe_updated(item):
	# add recipe main image
	var slot = Inventory.inventory_slot_scene.instantiate()
	recipe_image_container.add_child(slot)
	if item != null:
		slot.set_item(item)
	else:
		slot.set_empty()

	# requirements info
	for requirement in item['requirements']:
		print('requirements')
		var small_slot = Inventory.inventory_slot_small_scene.instantiate()
		recipe_requirements_container.add_child(small_slot)
		if requirement != null:
			small_slot.set_item(requirement)
		else:
			small_slot.set_empty()

func clear_grid_container():
	while recipe_requirements_container.get_child_count() > 0:
		var child = recipe_requirements_container.get_child(0)
		recipe_requirements_container.remove_child(child)
		child.queue_free()

	# remove recipe main image
	var child = recipe_image_container.get_child(0)
	recipe_image_container.remove_child(child)
