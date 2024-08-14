extends Control
class_name ShopSlot

@onready var icon = $InnerBorder/ItemIcon
@onready var label_qty = $InnerBorder/ItemQty
@onready var item_button = $ItemButton

signal recipe_slot_selected(recipe)

# Slot recipe item
var item = null

func set_empty():
	icon.texture = null
	label_qty.text = ''

func set_item(new_item):
	item = new_item
	icon.texture = item['texture']
	label_qty.text = str(item['qty']) 

func _on_item_button_pressed():
	recipe_slot_selected.emit(item)
