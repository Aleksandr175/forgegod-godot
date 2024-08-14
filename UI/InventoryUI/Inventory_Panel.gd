extends Control

signal inventory_closed

func _on_button_pressed():
	inventory_closed.emit()
