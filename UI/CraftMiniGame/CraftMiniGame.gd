extends Control

@onready var item_image = $ColorRect/MarginContainer/VBoxContainer/ItemImage
@onready var dots_container = $ColorRect/MarginContainer/VBoxContainer/DotContainer
@onready var close_button = $CloseButton

var item_data
var total_dots = 3
var dots_clicked = 0

func _ready():
	GlobalSignals.craft_game_opened.connect(start_crafting)
	GlobalSignals.craft_game_dot_pressed.connect(_on_dot_clicked)

func start_crafting(item):
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

	var placed_positions = []  # Store positions of placed dots
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
	var height = item_image.size.y - 50 - dot.size.y

	for attempt in range(max_attempts):
		var x = randf() * width
		var y = randf() * height - item_image.size.y

		var candidate = Vector2(x, y)
		if is_position_valid(candidate, existing_positions, min_distance):
			return candidate

	# If no valid position found after max_attempts, just place it anyway
	return Vector2(randf() * width, randf() * height - item_image.size.y)

func is_position_valid(candidate: Vector2, existing_positions: Array, min_dist: float) -> bool:
	for pos in existing_positions:
		if pos.distance_to(candidate) < min_dist:
			return false
	return true

func create_dot():
	var dot_scene = preload("res://UI/CraftMiniGame/Dot/Dot.tscn")
	var dot = dot_scene.instantiate()

	# Add a timer to the dot for its lifespan
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = randf_range(0.6, 1.2)

	# Store the Callable in the dot for later disconnection
	var timeout_callable = Callable(self, "_on_dot_timeout").bind(dot)
	timer.set_meta("timeout_callable", timeout_callable)  # Store the Callable

	timer.connect("timeout", timeout_callable)
	dots_container.add_child(timer)

	print("Timer duration:", timer.wait_time)  # Debug
	timer.start()

	dot.connect("dot_clicked", _on_dot_clicked)
	print("Connecting dot_clicked signal for:", dot)
	return dot

func _on_dot_timeout(dot):
	print("timeout")
	if not is_instance_valid(dot):
		return

	# Animate fade-out before removing
	var tween = create_tween()
	tween.tween_property(dot, "modulate", Color(1, 1, 1, 0), 0.3)
	await tween.finished
	
	_remove_dot(dot)

	# Gather valid positions from existing dots
	var existing_positions = []
	for child in dots_container.get_children():
		if child is Control:  # Ensure it's a Control node
			existing_positions.append(child.position)

	# Create a new dot and place it
	var new_dot = create_dot()
	var new_position = get_valid_dot_position(existing_positions, new_dot)
	new_dot.position = new_position
	dots_container.add_child(new_dot)

	# Animate fade-in
	var fade_in_tween = create_tween()
	new_dot.modulate = Color(1, 1, 1, 0)
	fade_in_tween.tween_property(new_dot, "modulate", Color(1, 1, 1, 1), 0.3)

func _on_dot_clicked(dot_node):
	dots_clicked += 1
	_remove_dot(dot_node)
	check_crafting_complete()

func _remove_dot(dot_node):
	if not dot_node or not is_instance_valid(dot_node):
		print("Dot node already removed or invalid.")
		return

	var parent = dot_node.get_parent()
	if not parent or not is_instance_valid(parent):
		print("Dot node has no valid parent.")
		return

	# Disconnect the dot_clicked signal
	if dot_node.is_connected("dot_clicked", _on_dot_clicked):
		dot_node.disconnect("dot_clicked", _on_dot_clicked)

	# Disconnect and remove ONLY the timer linked to this dot
	if dot_node.has_meta("timer"):
		var timer = dot_node.get_meta("timer")
		if timer and is_instance_valid(timer):
			if timer.is_connected("timeout", Callable(self, "_on_dot_timeout").bind(dot_node)):
				timer.disconnect("timeout", Callable(self, "_on_dot_timeout").bind(dot_node))
			timer.stop()
			timer.queue_free()

	print("Removing dot:", dot_node)
	dot_node.queue_free()

func check_crafting_complete():
	# If all dots are clicked (and removed), craft the item
	if dots_clicked >= total_dots:
		craft_item()

func craft_item():
	print('Crafted: ', item_data)

	Inventory.remove_items(item_data.requirements)
	# Add the item to the player's inventory
	Inventory.add_item(item_data.id, item_data.qty)

	QuestManager.update_objective_progress(Enums.QuestTypes.CRAFT, item_data.id, int(item_data.qty))
	close_crafting_ui()

func _on_close_button_pressed():
	close_crafting_ui()

func close_crafting_ui():
	# Stop and remove all timers in dots_container
	for child in dots_container.get_children():
		_remove_dot(child)

	print("Closing crafting UI.")
	GlobalSignals.craft_game_closed.emit()
