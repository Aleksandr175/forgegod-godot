extends Control

@onready var levels_container = $ColorRect/VBoxContainer/ScrollContainer/GridContainer
var level_buttons = {}

# Preload the LevelButton scene
var LevelButtonScene = preload("res://Stages/Levels/LevelButton.tscn")  # Adjust the path as needed

func _ready():
	populate_level_buttons()

func populate_level_buttons():
	# Remove existing buttons from the levels_container
	for child in levels_container.get_children():
		child.queue_free()  # Schedules the child node for deletion

	level_buttons.clear()

	for level_name in GameState.level_order:
		var level_info = GameState.levels[level_name]
		var level_button = LevelButtonScene.instantiate()

		# Set properties
		level_button.level_name = level_name
		level_button.level_info = level_info
		#level_button.resource_icons = get_resource_icons_for_level(level_name)

		# Add the level button to the container
		levels_container.add_child(level_button)
		level_buttons[level_name] = level_button

func create_level_button(level_name, level_info):
	var button = Button.new()
	button.text = level_name.capitalize()

	# Display resource icons
	#var resource_icons = get_resource_icons_for_level(level_name)
	#if resource_icons.size() > 0:
	#	var hbox = HBoxContainer.new()
	#	hbox.alignment = BoxContainer.ALIGN_CENTER

	#	for icon_path in resource_icons:
	#		var icon_texture = load(icon_path)
	#		var icon = TextureRect.new()
	#		icon.texture = icon_texture
	#		icon.rect_min_size = Vector2(32, 32)  # Adjust size as needed
	#		hbox.add_child(icon)

	#	button.add_child(hbox)
	#	hbox.anchor_right = 1
	#	hbox.margin_left = button.rect_size.x - (resource_icons.size() * 36)
	#	hbox.margin_top = (button.rect_size.y - 32) / 2

	# Connect the button press signal
	#button.connect("pressed", self, _on_level_button_pressed, [level_name])
	button.pressed.connect(func():
		_on_level_button_pressed(level_name)
	)

	return button

func _on_level_button_pressed(level_name):
	if GameState.levels[level_name]["unlocked"]:
		GameState.current_level_name = level_name
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Stages/Levels/" + level_name + ".tscn")
	else:
		print("Level is locked!")

func _on_village_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Stages/Levels/Village.tscn")

func on_level_completed(lvl_name):
	populate_level_buttons()

func _on_tree_entered():
	GlobalSignals.level_completed.connect(on_level_completed)

func _on_tree_exited():
	GlobalSignals.level_completed.disconnect(on_level_completed)
