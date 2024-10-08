@tool
extends Node2D

@export var item_name: String = ''
@export var item_type: String = ''
@export var item_texture: Texture
@export var item_qty: int = 1
var scene_path: String = "res://scenes/objects/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func add_item(qty: int = 1):	
	var item = Inventory.find_dictionary_item_by_name(item_name)

	if Inventory.player_node:
		Inventory.add_item(item.id, qty)

func die():
	add_item(item_qty)
	queue_free()

func get_damage():
	# TODO: play animation
	pass
