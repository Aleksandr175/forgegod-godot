extends Node2D

var increase_qty = 3
var item = Inventory.inventory_dictionary['iron']

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	Inventory.add_item({
		"id": item.id,
		"name": item.name,
		"qty": increase_qty,
		"texture": item.texture,
	})
	queue_free()

func get_damage():
	pass
