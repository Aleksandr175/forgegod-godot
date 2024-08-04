extends CanvasLayer

func _ready():
	GameManager.pause_menu = $PauseMenu
	# TODO: menu is opened, trigger play_pause twice to solve problem, why?
	GameManager.play_pause()
	GameManager.play_pause()

	GameManager.gained_coins.connect(update_coin_display)
	update_coin_display(GameManager.coins)

func _process(_delta):
	if Input.is_action_just_pressed("Open menu"):
		GameManager.play_pause()
		get_tree().paused = GameManager.isPaused
	
func update_coin_display(gained_coins):
	$CoinLabel.text = str(GameManager.coins)


func _on_resume_pressed():
	print('resume')
	GameManager.resume()

func _on_exit_pressed():
	GameManager.exit()
