extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = player.find_child("Camera2D")
	camera.limit_bottom = 1000000
	print(camera)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
