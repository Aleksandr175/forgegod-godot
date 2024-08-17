extends Area2D

#@onready var game_manager = %GameManager
@onready var animation_coin = $AnimationCoin

func _on_body_entered(body):
	if body is Player:
		#GameManager.add_point(1)
		var item = Inventory.inventory_dictionary["coin"]
		Inventory.add_item({
			"id": item.id,
			"name": item.name,
			"type": item.type,
			"texture": item.texture,
			"qty": 1
		})
		animation_coin.play("pickup")

