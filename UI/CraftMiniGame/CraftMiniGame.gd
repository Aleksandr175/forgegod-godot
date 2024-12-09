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

	# Collect references to all existing children first
	var children = dots_container.get_children()
	
	# Remove all existing dots
	for child in children:
		# Before queue_free, remove the child from the parent
		dots_container.remove_child(child)
		child.queue_free()

	# Create and add 3 dots at random positions
	for i in range(total_dots):
		var dot = create_dot()
		dots_container.add_child(dot)

		var x = randf() * (item_image.size.x - dot.size.x)
		var y = randf() * (item_image.size.y - dot.size.y) - item_image.size.y

		dot.position = Vector2(x, y)


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
