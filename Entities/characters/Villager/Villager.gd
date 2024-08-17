extends Node2D

var speed = 20  # Speed at which the villager moves
var target_position = Vector2()
var queue_index = -1  # Position in the queue
var wish = null
var reward = null
@onready var villager_panel = $VillagerUi
@onready var sprite = $AnimatedSprite2D

func _ready():
	villager_panel.visible = false
	generate_wish()
	find_building()

func _process(delta):
	sprite.play("run")
	sprite.flip_h = true
	move_to_queue_position(delta)

func generate_wish():
	var possible_wishes = Inventory.recipes
	wish = possible_wishes[randi() % possible_wishes.size()]
	# villager wants to buy only 1 item
	wish.qty = 1
	
	var wishItem = Inventory.find_item_by_id(wish.id)
	
	reward = {
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
		#print(target_position)

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
	# This function could be called when a villager has finished their interaction
	queue_free()  # Remove the villager from the scene

	# Optionally, notify the spawner to update the queue
	get_parent().call_deferred("free_queue_position", target_position)


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and wish:
		villager_panel.visible = true


func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		villager_panel.visible = false


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
