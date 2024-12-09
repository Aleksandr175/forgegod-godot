extends Control

@onready var item_image = $ColorRect/MarginContainer/VBoxContainer/ItemImage
@onready var dots_container = $ColorRect/MarginContainer/VBoxContainer/DotContainer
@onready var close_button = $CloseButton

var item_data
var total_dots = 3
var dots_clicked = 0

func _ready():
	print('craft mini game ready...')
	GlobalSignals.craft_game_opened.connect(start_crafting)
	GlobalSignals.craft_game_dot_pressed.connect(_on_dot_clicked)
	#close_button.connect("pressed", _on_close_button_pressed)

func start_crafting(item):
	print('start_crafting craft item', item)
	item_data = item
	item_image.texture = item.texture  # Ensure your item_data has a texture property

	generate_dots()

func generate_dots():
	dots_clicked = 0

	# Remove all existing dots
	var children = dots_container.get_children()
	for child in children:
		dots_container.remove_child(child)
		child.queue_free()

	var placed_positions = []  # To store positions of already placed dots

	for i in range(total_dots):
		var dot = create_dot()
		
		var position = get_valid_dot_position(placed_positions, dot)
		dot.position = position

		dots_container.add_child(dot)
		placed_positions.append(position)

func get_valid_dot_position(existing_positions: Array, dot: Control) -> Vector2:
	var max_attempts = 20
	var min_distance = 100.0

	var width = item_image.size.x - dot.size.x
	var height = item_image.size.y - dot.size.y

	for attempt in range(max_attempts):
		var x = randf() * width
		var y = randf() * height - item_image.size.y

		var candidate = Vector2(x, y)
		if is_position_valid(candidate, existing_positions, min_distance):
			return candidate

	# If no valid position found after max_attempts, just place it anyway
	# But better to handle this gracefully
	return Vector2(randf() * width, randf() * height - item_image.size.y)

func is_position_valid(candidate: Vector2, existing_positions: Array, min_dist: float) -> bool:
	for pos in existing_positions:
		if pos.distance_to(candidate) < min_dist:
			return false
	return true

func create_dot():
	var dot_scene = preload("res://UI/CraftMiniGame/Dot/Dot.tscn")
	var dot = dot_scene.instantiate()

	dot.connect("dot_clicked", _on_dot_clicked)
	return dot

func _on_dot_clicked(dot_node):
	print('dot clicked ', dot_node)
	dots_clicked += 1
	_remove_dot(dot_node)

func _remove_dot(dot_node):
	dot_node.get_parent().remove_child(dot_node)  # Explicitly remove from parent
	dot_node.queue_free()
	check_crafting_complete()

func check_crafting_complete():
	print('check_crafting_complete', 'dots_clicked', dots_clicked, 'count ->', dots_container.get_child_count())
	# If all dots are clicked (and removed), craft the item
	if dots_clicked >= total_dots and dots_container.get_child_count() == 0:
		craft_item()

func craft_item():
	print('Crafted', item_data)
	# Add the item to the player's inventory
	Inventory.add_item(item_data.id, item_data.qty)
	close_crafting_ui()

func _on_close_button_pressed():
	close_crafting_ui()

func close_crafting_ui():
	GlobalSignals.craft_game_closed.emit()
