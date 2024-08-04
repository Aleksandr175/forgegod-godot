extends Node

signal gained_coins(int)
var coins: int = 0
var isPaused = false

@onready var score_label = $ScoreLabel
var player: Player
var current_checkpoint: Checkpoint
var pause_menu

func add_point(gained_coins: int):
	coins += gained_coins
	emit_signal("gained_coins", gained_coins)
	#score_label.text = "You collected " + str(coins) + " coins."

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
