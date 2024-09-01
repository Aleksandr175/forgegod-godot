extends Node

@onready var sprite = $AnimatedSprite2D
@export var direction: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
