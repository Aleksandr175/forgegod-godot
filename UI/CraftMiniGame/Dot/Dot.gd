extends Control

signal dot_clicked

var is_clicked = false

func _on_touch_screen_button_pressed():
	print('try click')
	if not is_clicked:
		is_clicked = true
		print('clicked')
		emit_signal("dot_clicked")
		queue_free()  # Remove the dot after clicking
