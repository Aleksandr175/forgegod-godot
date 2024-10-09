extends Control

func _on_button_pressed():
	GlobalSignals.inventory_closed.emit()
