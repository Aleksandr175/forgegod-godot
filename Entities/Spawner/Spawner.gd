extends Node2D

@onready var villager_scene = preload("res://Entities/characters/Villager/Villager.tscn")
@onready var timer = $Timer
var villagers_in_queue: Array = []

var x = 0
var queue_positions = [
	Vector2(x, 0),  # First position (closest to the building)
	Vector2(x + 22, 0),  # Second position
	Vector2(x + 45, 0),  # Third position
]

func _ready():
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	spawn_villager()

func spawn_villager():
	#print('spawn', villagers_in_queue, queue_positions)
	if villagers_in_queue.size() < queue_positions.size():
		var villager_instance = villager_scene.instantiate()
		add_child(villager_instance)

		# Assign the next available queue position to the villager
		var next_position_index = villagers_in_queue.size()
		var queue_position = queue_positions[next_position_index] + get_parent().get_node("MainBuilding").position
		queue_position.y = 0  # Only move horizontally

		villager_instance.set_queue_position(queue_position)
		villager_instance.queue_index = next_position_index
		villagers_in_queue.append(villager_instance)

		# Connect the villager's wish completed signal
		#villager_instance.connect("wish_completed", _on_villager_wish_completed)
	else:
		print("All queue positions are occupied.")

func free_queue_position(villager):
	#print('completed wish _on_villager_wish_completed', villager)
	villagers_in_queue.erase(villager)
	#villager.queue_free()

	# Shift the queue forward
	for i in range(villager.queue_index, villagers_in_queue.size()):
		villagers_in_queue[i].queue_index = i
		villagers_in_queue[i].set_queue_position(queue_positions[i] + get_parent().get_node("MainBuilding").position)
