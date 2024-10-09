extends Node2D

@onready var pointer = $Pointer


func _on_pointer_pointer_pressed():
	GlobalSignals.inventory_opened.emit()

func _on_area_2d_area_exited(area):
	GlobalSignals.inventory_closed.emit()
