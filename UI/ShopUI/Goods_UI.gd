extends Control
class_name GoodsUI

@onready var shop_slots_container = $VBoxContainer/ScrollContainer/GridContainer

signal good_bought(item)

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_goods_updated()

func _on_goods_updated():
	clear_grid_container()
	# Add slots for each goods position
	for item in Inventory.shop_items:
		var slot = Inventory.shop_slot_scene.instantiate()
		shop_slots_container.add_child(slot)
		if item != null:
			print(slot, item)
			slot.set_item(item)
			# Connect the recipe_slot_selected signal from each slot
			slot.shop_slot_selected.connect(_on_shop_item_bought)
		else:
			slot.set_empty()
			
	
func clear_grid_container():
	while shop_slots_container.get_child_count() > 0:
		var child = shop_slots_container.get_child(0)
		shop_slots_container.remove_child(child)
		child.queue_free()
		#print('clear_grid_container shop slots', shop_slots_container.get_child_count())

# Callback function that handles we buy shop item
func _on_shop_item_bought(item):
	if Inventory.has_enought_coins(item.price):
		print("Shop item bought!", item)
		var bought_item = {
			"id": item["id"],
			"name": item["name"],
			"texture": item["texture"],
			"qty": 1,
		}
		# we should remove coins from inventory
		var coins_item = {
			"id": Inventory.inventory_dictionary["coin"]["id"],
			"qty": item["price"],
		}
		print(coins_item)
		
		Inventory.add_item(bought_item)
		Inventory.remove_item(coins_item)
