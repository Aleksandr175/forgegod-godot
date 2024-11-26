extends Control

var selected_recipe = null
@onready var recipe_image_container = $VBoxContainer/HBoxContainer/RecipeImageContainer
@onready var recipe_requirements_container = $VBoxContainer/HBoxContainer/VBoxContainer/GridRequirements
@onready var recipe_name = $VBoxContainer/HBoxContainer/VBoxContainer/Label
@onready var craft_button = $VBoxContainer/Button
@onready var particles = $VBoxContainer/CPUParticles2D  # Reference to the particle system
@onready var forge_sound = $ForgeSound

# Called when the node enters the scene tree for the first time.
func _ready():
	particles.emitting = false
	var recipes = Inventory.get_unlocked_recipes()
	_on_selected_recipe_updated(recipes[0])

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

	set_craft_button_available(item['requirements'])

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
	_on_selected_recipe_updated(recipeData)

func find_item_by_name(recipe_name):
	for item in Inventory.recipes:
		if item.name == recipe_name:
			return item
	return null  # Return null if the item is not found

func order(recipe):
	if Inventory.has_required_items(recipe.requirements):
		# Proceed with item creation
		print("All requirements met. Creating item:", recipe.name, recipe.id)

		Inventory.remove_items(recipe.requirements)

		# Add the new item to the inventory
		Inventory.add_item(recipe.id, int(recipe.qty))

		QuestManager.update_objective_progress(Enums.QuestTypes.CRAFT, recipe.id, int(recipe.qty))
		set_craft_button_available(recipe.requirements)
	else:
		print("Not enough resources to create:", recipe.name)

func _on_button_pressed():
	order(selected_recipe)
	# play forge sound
	forge_sound.play()

	particles.emitting = true  # Start emitting particles
	
	# Optionally, you can stop emitting after a short delay
	await get_tree().create_timer(0.5).timeout
	particles.emitting = false
	
func set_craft_button_available(requirements):
	if Inventory.has_required_items(requirements):
		craft_button.disabled = false
	else:
		craft_button.disabled = true
