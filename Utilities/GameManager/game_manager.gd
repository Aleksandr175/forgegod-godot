extends Node

signal gained_coins
signal gained_resource_iron
var coins: int = 3
var isPaused = false

var resources = {
	'iron': 5
}

var player: Player
var current_checkpoint: Checkpoint
var pause_menu

func _ready():
	#if OS.is_debug_build():
	#	print("Debug mode detected, skipping dynamic screen size adjustments.")
	#	return  # Skip the rest of the code if in debug mode

	# Set the window size to match the screen size
	var screen_size = get_viewport().get_visible_rect().size
	print("Current Screen Size:", screen_size)

	# Set the window size dynamically
	#DisplayServer.window_set_size(screen_size)
	#DisplayServer.window_set_mode(DisplayServer.WindowMode.FULLSCREEN)

func add_point(inceased_coins: int):
	coins += inceased_coins
	gained_coins.emit()
	#emit_signal("gained_coins", gained_coins)

#func add_resource(resource_type: String, qty: int):
#	resources[resource_type] += qty
#	if (resource_type == 'iron'):
#		gained_resource_iron.emit()
		#emit_signal("gained_resource_iron")

func play_pause():
	isPaused = !isPaused
	pause_menu.visible = isPaused
	get_tree().paused = isPaused

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func resume():
	play_pause()

func restart():
	get_tree().reload_current_scene()
		
func exit():
	# It is not working on iOS, but maybe it will be needed for other OS
	get_tree().quit()
