extends Node2D

signal level_menu_opened

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	print('enter', body)
	
	if body is Player:
		level_menu_opened.emit()
