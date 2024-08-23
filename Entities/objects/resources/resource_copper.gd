extends Node2D

@export var resourceDictionaryId: String
var increase_qty = 3
var item = null

func die():
	item = Inventory.inventory_dictionary[resourceDictionaryId]
	Inventory.add_item({
		"id": item.id,
		"name": item.name,
		"qty": increase_qty,
		"texture": item.texture,
	})
	queue_free()

func get_damage():
	# TODO: play animation
	pass
