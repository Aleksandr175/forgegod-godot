extends Node2D

@export var resourceDictionaryId: String
var increase_qty = 3
var item = null
@onready var sprite_2d = $Sprite2D

func die():
	item = Inventory.inventory_dictionary[resourceDictionaryId]
	Inventory.add_item({
		"id": item.id,
		"name": item.name,
		"qty": increase_qty,
		"texture": item.texture,
		"type": item.type,
	})
	queue_free()

func get_damage():
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.3)

func SetShader_BlinkIntensity(newValue: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", newValue)
	
