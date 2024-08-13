extends Control

signal shop_ui_closed

func _on_button_pressed():
	shop_ui_closed.emit()
	pass # Replace with function body.
