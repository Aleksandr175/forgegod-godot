extends Node

@onready var villager_scene = preload("res://Entities/characters/Villager/Villager.tscn")
@onready var timer = $Timer

var queue_positions = [
	Vector2(10, 0),  # First position (closest to the building)
	Vector2(30, 0),  # Second position
	Vector2(50, 0),  # Third position
	#Vector2(70, 0)   # Fourth position, and so on...
]
var occupied_positions = []

func _ready():
	timer.connect("timeout", _on_timer_timeout)
	
func _on_timer_timeout():
	spawn_villager()

func spawn_villager():
	print('spawn', occupied_positions, queue_positions)
	if occupied_positions.size() < queue_positions.size():
		var villager_instance = villager_scene.instantiate()
		add_child(villager_instance)

		# Set the villager's initial position (spawn point)
		#villager_instance.position = Vector2(rand_range(100, 400), rand_range(100, 300))

		# Assign the next available queue position to the villager
		var next_position_index = occupied_positions.size()
		print(next_position_index, queue_positions)
		var queue_position = queue_positions[next_position_index] + get_parent().get_node("MainBuilding").position
		# our villager goes only horizontally
		queue_position.y = 0

		villager_instance.set_queue_position(queue_position)

		# Mark this position as occupied
		occupied_positions.append(queue_position)
	else:
		print("All queue positions are occupied.")

func free_queue_position(position):
	occupied_positions.erase(position)
