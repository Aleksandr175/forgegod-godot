extends Control

var selected_recipe = null
@onready var recipe_image_container = $VBoxContainer/HBoxContainer/RecipeImageContainer
@onready var recipe_requirements_container = $VBoxContainer/HBoxContainer/VBoxContainer/GridRequirements
@onready var recipe_name = $VBoxContainer/HBoxContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_selected_recipe_updated(Inventory.recipes[0])

func _on_selected_recipe_updated(item):
	clear_grid_container()
	recipe_name.text = item.name
	selected_recipe = item

	# add recipe main image
	var slot = Inventory.recipe_slot_scene.instantiate()
	recipe_image_container.add_child(slot)
	if item != null:
		slot.set_item(item)
	else:
		slot.set_empty()

	# requirements info
	for requirement in item['requirements']:
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
	var child_image = recipe_image_container.get_child(0)
	recipe_image_container.remove_child(child_image)


func _on_recipes_ui_recipe_ui_slot_selected(recipe):
	var recipeData = find_item_by_name(recipe.name)
	_on_selected_recipe_updated(recipe)

func find_item_by_name(recipe_name):
	for item in Inventory.recipes:
		if item.name == recipe_name:
			return item
	return null  # Return null if the item is not found

func order(recipe):
	if Inventory.has_required_items(recipe.requirements):
		# Proceed with item creation
		print("All requirements met. Creating item:", recipe.name)
		
		Inventory.remove_items(recipe.requirements)
		
		# Add the new item to the inventory
		var new_item = {
			"qty": int(recipe.qty),
			"name": recipe.name,
			"type": "resource",
			"texture": recipe.texture,
		}
		
		Inventory.add_item(new_item)
	else:
		print("Not enough resources to create:", recipe.name)

func _on_button_pressed():
	order(selected_recipe)
	pass # Replace with function body.
