extends Node2D

var increase_qty = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	GameManager.add_resource('iron', increase_qty)
	queue_free()

func get_damage():
	pass
