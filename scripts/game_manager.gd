extends Node

var score = 0

@onready var score_label = $ScoreLabel
var player: Player
var current_checkpoint: Checkpoint

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
