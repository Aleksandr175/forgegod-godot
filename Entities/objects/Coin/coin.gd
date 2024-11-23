extends Area2D

@onready var collect_sound = $CollectSound  # Reference to the AudioStreamPlayer
@onready var coin_sprite = $AnimatedSprite2D

var item = Inventory.inventory_dictionary["coin"]

func _on_body_entered(body):
	if body is Player:
		Inventory.add_item(item.id, 1)
		
		# Update quest objective for collecting coins
		QuestManager.update_objective_progress(Enums.QuestTypes.COLLECT, str(item.id), 1)
		
		GlobalSignals.resource_picked_up.emit("Coin", 1)
		
		# Play the collection sound
		collect_sound.play()
		
		# Disable collision to prevent multiple pickups
		set_deferred("monitoring", false)
		set_collision_layer(0)
		set_collision_mask(0)
		
		# Optionally, hide the coin's visual representation
		coin_sprite.visible = false  # Replace 'CoinSprite' with the name of your sprite node
		
		# Connect to the 'finished' signal of the collect_sound
		collect_sound.connect("finished", self._on_collect_sound_finished)

func _on_collect_sound_finished():
	# Remove the coin from the scene
	queue_free()
