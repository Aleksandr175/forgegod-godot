extends CanvasLayer

func _ready():
	GameManager.pause_menu = $PauseMenu
	# TODO: menu is opened, trigger play_pause twice to solve problem, why?
	GameManager.play_pause()
	GameManager.play_pause()

	#GameManager.gained_coins.connect(update_coin_display)
	#GameManager.gained_resource_iron.connect(update_iron_display)
	#update_coin_display()
	#update_iron_display()

func _process(_delta):
	if Input.is_action_just_pressed("Open menu"):
		GameManager.play_pause()
		get_tree().paused = GameManager.isPaused
	
func update_coin_display():
	#$CoinLabel.text = str(GameManager.coins)
	pass

func update_iron_display():
	#$IronLabel.text = str(GameManager.resources.iron)
	pass

func _on_resume_pressed():
	GameManager.resume()

func _on_exit_pressed():
	GameManager.exit()

func _on_new_game_pressed():
	GameState.start_new_game()
	GameManager.resume()
