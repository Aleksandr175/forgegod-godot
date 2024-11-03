extends Button

# Exports for setting up the button
@export var level_name: String = ""
@export var level_label: String = ""
var level_info: Dictionary
var resource_icons: Array[String] = []

# Node references
@onready var level_name_label = %Label
#@onready var icon_container = $button_container/icon_container
#@onready var lock_icon = $lock_icon

func _ready():
	# Set the level name label
	level_name_label.text = level_label.capitalize()

	# Add resource icons
	#add_resource_icons()

	# Show or hide the lock icon
	update_lock_status()

	# Connect the pressed signal
	pressed.connect(_on_button_pressed)

#func add_resource_icons():
	# Clear existing icons
#	for child in icon_container.get_children():
#		child.queue_free()

	# Add icons to the icon_container
#	for icon_path in resource_icons:
#		var icon_texture = load(icon_path)
#		var icon = TextureRect.new()
#		icon.texture = icon_texture
#		icon.rect_min_size = Vector2(32, 32)  # Adjust size as needed
#		icon_container.add_child(icon)

func update_lock_status():
	if level_name and GameState.level_progress[level_name]["unlocked"]:
		disabled = false
#		lock_icon.visible = false
	else:
		disabled = true
#		lock_icon.visible = true

func _on_button_pressed():
	if GameState.is_level_unlocked(level_name):
		GameState.current_level_name = level_name
		get_tree().paused = false
		SceneManager.change_scene("res://Stages/Levels/" + level_name + ".tscn")
	else:
		print("Level is locked!")
