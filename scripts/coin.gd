extends Area2D

@onready var game_manager = %GameManager
@onready var animation_coin = $AnimationCoin

func _on_body_entered(body):
	if body is Player:	
		game_manager.add_point(1)
		animation_coin.play("pickup")

