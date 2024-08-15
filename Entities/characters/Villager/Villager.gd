extends Node2D

var speed = 20  # Speed at which the villager moves
var target_position = Vector2()
var queue_index = -1  # Position in the queue
var wish = null

@onready var sprite = $AnimatedSprite2D

func _ready():
	generate_wish()
	find_building()

func _process(delta):
	sprite.play("run")
	sprite.flip_h = true
	move_to_queue_position(delta)

func generate_wish():
	var possible_wishes = Inventory.recipes
	var wish = possible_wishes[randi() % possible_wishes.size()]
	# villager wants to buy only 1 item
	wish.qty = 1
	print("Villager wants to buy: ", wish)

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
