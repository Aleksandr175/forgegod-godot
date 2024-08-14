extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_ladder_area_area_entered(area):
	var body = area.get_parent()
	
	if body is Player:
		# Notify the player that it exited the ladder area
		body.start_climbing()

func _on_ladder_area_area_exited(area):
	var body = area.get_parent()
	
	if body is Player:
		# Notify the player that it exited the ladder area
		body.stop_climbing()
