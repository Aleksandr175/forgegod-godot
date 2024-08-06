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

func add_point(inceased_coins: int):
	coins += inceased_coins
	gained_coins.emit()
	#emit_signal("gained_coins", gained_coins)

func add_resource(resource_type: String, qty: int):
	resources[resource_type] += qty
	if (resource_type == 'iron'):
		gained_resource_iron.emit()
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
	get_tree().quit()
