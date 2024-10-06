extends Node2D

@onready var portal = $Portal

# Called when the node enters the scene tree for the first time.
func _ready():
	portal.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_portal_portal_entered():
	SceneManager.change_scene("res://Stages/Levels/Village.tscn")
