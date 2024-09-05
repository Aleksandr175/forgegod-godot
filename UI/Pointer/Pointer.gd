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


func _on_area_2d_area_entered(area):
	var body = area.get_parent()

	if body is Player or body is PlayerHouse:
		pointer.visible = true


func _on_area_2d_area_exited(area):
	var body = area.get_parent()
	
	if body is Player or body is PlayerHouse:
		pointer.visible = false
