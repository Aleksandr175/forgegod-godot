extends Node2D

signal portal_entered

@onready var camera = get_node("../Player/Camera2D")
@onready var area = $Area2D  # Reference to the Area2D node
var zoom_duration = 1.0  # Duration of the zoom in seconds
var target_zoom = Vector2(7, 7)  # Desired zoom level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	print('fdsfsffsfs')

	if body is Player:
		zoom_in_to_portal()
		#level_menu_opened.emit()

func zoom_in_to_portal():
	print('ffffff')
	var tween = create_tween()
	
	# Set up the tween animation to zoom the camera
	tween.tween_property(camera, "zoom", target_zoom, zoom_duration)
	
	# Connect the 'finished' signal using Callable
	tween.connect("finished", Callable(self, "_on_zoom_finished"))

func _on_zoom_finished():
	print('4444444')
	# Zoom animation is finished, now emit the signal
	emit_signal("portal_entered")
	pass
