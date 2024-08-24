extends Node2D

signal pointer_pressed

@onready var pointer = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pointer.visible = false
	pass # Replace with function body.

func _on_touch_screen_button_pressed():
	if pointer.visible:
		pointer_pressed.emit()
