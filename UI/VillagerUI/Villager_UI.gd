extends Control

signal button_pressed

func _on_button_pressed():
	button_pressed.emit()

func update_panel(wish):
	print('update_wish', wish)
