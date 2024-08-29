extends Area2D

#@onready var game_manager = %GameManager
@onready var animation_coin = $AnimationCoin

var item = Inventory.inventory_dictionary["coin"]

func _on_body_entered(body):
	if body is Player:
		Inventory.add_item({
			"id": item.id,
			"name": item.name,
			"type": item.type,
			"texture": item.texture,
			"qty": 1
		})

		# Update quest objective for collecting coins
		QuestManager.update_objective_progress("collect", str(item.id), 1)

		animation_coin.play("pickup")
		
