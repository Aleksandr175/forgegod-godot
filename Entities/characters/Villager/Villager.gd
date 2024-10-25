extends Node2D

var speed: int = 20  # Speed at which the villager moves
var target_position: Vector2 = Vector2()
var queue_index: int = -1  # Position in the queue
var wish = null
var reward = null
var returning_to_spawner = false
var spawner_position: Vector2  # Define the variable to hold the spawner's position
@onready var villager_panel = $VillagerUi
@onready var sprite = $AnimatedSprite2D

func _ready():
	randomize()
	villager_panel.visible = false
	generate_wish()
	find_building()

func _process(delta):
	sprite.play("run")

	if returning_to_spawner:
		move_to_spawner(delta)
		sprite.flip_h = false
	else:
		move_to_queue_position(delta)
		sprite.flip_h = true

func generate_wish():
	var unlocked_recipes = Inventory.get_unlocked_recipe_data()
	if unlocked_recipes.size() == 0:
		# No unlocked recipes; villager cannot have a wish
		print("No unlocked recipes available for villager wishes.")
		wish = null
		return

	# Select a random recipe from the unlocked recipes
	wish = unlocked_recipes[randi() % unlocked_recipes.size()]

	# Villager wants to buy only 1 item
	wish.qty = 1
	
	var wishItem = Inventory.find_dictionary_item_by_id(wish.id)
	
	reward = {
		"id": Inventory.inventory_dictionary["coin"]["id"],
		"name": Inventory.inventory_dictionary["coin"]["name"],
		"texture": Inventory.inventory_dictionary["coin"]["texture"],
		"type": Inventory.inventory_dictionary["coin"]["type"],
		"qty": wishItem.value,
	}

	update_wish_panel(wish, reward)
	

func find_building():
	# Assuming the building is a node in the same scene
	var building = get_parent().get_node("MainBuilding")
	if building:
		target_position = building.position

func move_to_queue_position(delta):
	if position.distance_to(target_position) > 5:  # A small threshold to stop the villager at the queue position
		var direction = (target_position - position).normalized()
		position += direction * speed * delta
	else:
		# Villager has reached its queue position
		#print("Villager is waiting in the queue.")
		sprite.play("idle")
		# Perform additional actions like idle animations or waiting for their turn

func set_queue_position(queue_pos):
	target_position.x = queue_pos.x

func leave_queue():
	# Optionally, notify the spawner to update the queue
	get_parent().call_deferred("free_queue_position", self)
	target_position = spawner_position
	target_position.y = 0
	returning_to_spawner = true


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and wish:
		open_wish_panel()

func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		close_wish_panel()

func update_wish_panel(wishData, rewardData):
	var wish_slot = villager_panel.get_node("ColorRect/MarginContainer/VBoxContainer/HBoxContainer/InventorySlotWanted")
	var reward_slot = villager_panel.get_node("ColorRect/MarginContainer/VBoxContainer/HBoxContainer/InventorySlotReward")

	wish_slot.set_item({
		"texture": wishData['texture'],
		"qty": wishData["qty"],
		"name": wishData['name'],
		"type": wishData['type']
	})
	
	reward_slot.set_item({
		"texture": rewardData['texture'],
		"qty": rewardData["qty"],
		"name": rewardData['name'],
		"type": rewardData['type']
	})


func _on_villager_ui_button_pressed():
	if wish and Inventory.has_enough_resources([wish]):
		Inventory.add_item(reward.id, reward.qty)
		Inventory.remove_items([wish])
		QuestManager.update_objective_progress(Enums.QuestTypes.SELL, wish.id, 1)
		
		wish = null
		close_wish_panel()
		leave_queue()

func open_wish_panel():
	if wish != null:
		villager_panel.visible = true
	else:
		villager_panel.visible = false

func close_wish_panel():
	villager_panel.visible = false

func move_to_spawner(delta):
	if position.distance_to(target_position) > 5:
		var direction = (target_position - position).normalized()
		position += direction * speed * delta
	else:
		# Play exit animation, then queue free
		play_exit_animation()

func play_exit_animation():
	sprite.play("disappear")
	#yield(sprite, "animation_finished")
	queue_free()
