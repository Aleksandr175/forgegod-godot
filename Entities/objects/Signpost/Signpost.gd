extends Node2D

@export var direction: String = 'right'
@export var description: String = ''
@onready var sprite = $Sprite2D
@onready var signpost_panel = $Control
@onready var description_label = $Control/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	signpost_panel.visible = false
	description_label.text = description
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if direction == 'right':
		sprite.flip_h = false
	else:
		sprite.flip_h = true


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		signpost_panel.visible = true


func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		signpost_panel.visible = false
