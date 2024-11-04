extends Control

func _on_button_pressed():
	GlobalSignals.craft_menu_closed.emit()
