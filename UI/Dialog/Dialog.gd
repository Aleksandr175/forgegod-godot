extends Control

var current_dialog_index = 0
@onready var rich_text_label = $ColorRect/RichTextLabel
@onready var dialog_ui = $"."
@onready var character_image = $ColorRect/TextureRect

var char_index = 0
var current_text = ""
var full_text = ""
var typing_speed = 0.05  # Delay between letters

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

func start_dialog(dialogItem):
	full_text = dialogItem["text"]
	current_text = ""
	#char_index = 0
	
	rich_text_label.text = full_text
	#var timer = get_tree().create_timer(typing_speed, true)  # true for repeating the timer
	#timer.connect("timeout", Callable(self, "show_next_character"))
	#get_tree().create_timer(typing_speed).connect("timeout", self, "show_next_character", [], true)

	set_character_image(dialogItem["character"])

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
	current_dialog_index += 1
	#print(dialog_data.size(), current_dialog_index)
	if dialog_data.size() > current_dialog_index:
		start_dialog(dialog_data[current_dialog_index])
	else:
		close_dialog()


func _on_touch_screen_button_pressed():
	_on_button_pressed()
