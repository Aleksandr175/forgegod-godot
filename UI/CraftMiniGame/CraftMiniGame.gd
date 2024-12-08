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
	#close_button.connect("pressed", _on_close_button_pressed)

func start_crafting(item):
	print('start_crafting craft item', item)
	item_data = item
	item_image.texture = item.texture  # Ensure your item_data has a texture property

	generate_dots()

func generate_dots():
	dots_clicked = 0
	dots_container.call_deferred("clear_children")

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
	dots_clicked += 1

	# Play small animation on the dot before removing it
	# We can run a tween or call an animation here
	play_dot_animation(dot_node)

func play_dot_animation(dot_node):
	# Example using a Tween for a simple scale animation
	var tween = create_tween()
	tween.tween_property(dot_node, "scale", Vector2(2,2), 0.2)  # Scale up in 0.2s
	#tween.tween_callback(Callable(self, "_remove_dot"), dot_node)  # After done, remove dot

func _remove_dot(dot_node):
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
	#UIManager.show_message("You have crafted: " + item_data.name)
	close_crafting_ui()

func _on_close_button_pressed():
	# Close the mini-game without crafting if the player cancels
	close_crafting_ui()

func close_crafting_ui():
	GlobalSignals.craft_game_closed.emit()
	#queue_free()
