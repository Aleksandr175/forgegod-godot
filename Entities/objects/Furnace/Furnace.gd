extends Node2D

signal inventory_opened

@onready var pointer = $Pointer


func _on_pointer_pointer_pressed():
	inventory_opened.emit()
