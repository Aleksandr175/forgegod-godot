extends Node2D

@onready var portal = $Portal

# Called when the node enters the scene tree for the first time.
func _ready():
	portal.visible = false

func _on_portal_portal_entered():
	SceneManager.change_scene("res://Stages/Levels/Village.tscn", "from_portal")
