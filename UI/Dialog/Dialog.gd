extends Control

var current_dialog_index = 0
@onready var rich_text_label = $ColorRect/MarginContainer/HBoxContainer/RichTextLabel
@onready var dialog_ui = $"."
@onready var character_image = $ColorRect/MarginContainer/HBoxContainer/VBoxContainer/TextureRect

var char_index = 0
var current_text = ""
var full_text = ""
var typing_speed = 0.01  # Delay between letters

var dialog_data = null
#var dialog_data = [
#	{"character": "player", "text": "I need to find the dealer."},
#	{"character": "dealer", "text": "What do you want to buy?"},
#	{"character": "player", "text": "I need some weapons."}
#]

# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_ui.visible = false
	GlobalSignals.start_dialog.connect(show_dialog)
	rich_text_label.clear()

func start_dialog_sequence(dialog):
	current_dialog_index = 0
	start_dialog(dialog[current_dialog_index])

func show_dialog(dialog):
	if dialog and dialog.size() > 0:
		dialog_data = dialog
		get_tree().paused = true  # Pause game

		dialog_ui.visible = true
		start_dialog_sequence(dialog_data)

func on_text_displayed():
	current_dialog_index += 1
	#if current_dialog_index < dialog_data.size():
	#	show_dialog(dialog_data[current_dialog_index])
	#else:
	#	close_dialog()

func close_dialog():
	print('close')
	get_tree().paused = false  # Resume the game
	hide_dialog_ui()

func hide_dialog_ui():
	dialog_ui.visible = false

func show_next_character():
	if char_index < full_text.length():
		current_text += full_text[char_index]
		rich_text_label.text = current_text
		char_index += 1
	else:
		# Text fully displayed
		#get_tree().paused = false  # Resume game after dialog
		rich_text_label.text = full_text

func start_dialog(dialog_item):
	# Prepare the full text and reset the current text
	full_text = dialog_item["text"]
	current_text = ""
	char_index = 0
	rich_text_label.text = ""

	# Set the character image
	set_character_image(dialog_item["character"])

	# Start the typing animation
	show_text_typing()

func show_text_typing():
	# Display one character at a time with a delay
	while char_index < full_text.length():
		current_text += full_text[char_index]
		rich_text_label.text = current_text
		char_index += 1

		# Wait for the typing speed before continuing
		await get_tree().create_timer(typing_speed).timeout

	# Once the text is fully displayed, allow for further input
	rich_text_label.text = full_text


func set_character_image(character_name):
	match character_name:
		"player":
			character_image.texture = preload("res://assets/sprites/characters/portraits/player.png")
		"dealer":
			character_image.texture = preload("res://assets/sprites/characters/portraits/dealer.png")
		"king":
			character_image.texture = preload("res://assets/sprites/characters/portraits/elder.png")
		"soldier":
			character_image.texture = preload("res://assets/sprites/characters/portraits/soldier.png")
		"villager":
			character_image.texture = preload("res://assets/sprites/characters/portraits/villager.png")
		_:
			character_image.texture = null
	pass


func _on_button_pressed():
	if char_index < full_text.length():
		# Skip typing and display the full text immediately
		rich_text_label.text = full_text
		char_index = full_text.length()
	else:
		# Proceed to the next dialog or close
		current_dialog_index += 1
		if current_dialog_index < dialog_data.size():
			start_dialog(dialog_data[current_dialog_index])
		else:
			close_dialog()


func _on_touch_screen_button_pressed():
	_on_button_pressed()
