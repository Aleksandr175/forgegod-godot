extends Node

signal gained_coins(int)
var coins: int = 0

@onready var score_label = $ScoreLabel
var player: Player
var current_checkpoint: Checkpoint

func add_point(gained_coins: int):
	coins += gained_coins
	emit_signal("gained_coins", gained_coins)
	#score_label.text = "You collected " + str(coins) + " coins."

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
