extends CanvasLayer

func _ready():
	GameManager.gained_coins.connect(update_coin_display)
	update_coin_display(GameManager.coins)
	
func update_coin_display(gained_coins):
	$CoinLabel.text = str(GameManager.coins)
