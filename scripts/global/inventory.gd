extends Node2D

var inventoryItems = []

signal inventory_updated

# Scene and node references
var player_node: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	inventoryItems.resize(30)
	pass # Replace with function body.

func add_item():
	inventory_updated.emit()
	
func remove_item():
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player
