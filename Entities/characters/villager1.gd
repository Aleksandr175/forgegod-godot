extends Node2D

@export var direction: int = 1
@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
