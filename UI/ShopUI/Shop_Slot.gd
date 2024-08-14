extends Control
class_name RecipeSlot

@onready var icon = $InnerBorder/ItemIcon
@onready var label_price = $InnerBorder/Price
@onready var item_button = $ItemButton

signal shop_slot_selected(item)

# Slot recipe item
var item = null

func set_empty():
	icon.texture = null
	label_price.text = ''

func set_item(new_item):
	item = new_item
	icon.texture = item['texture']
	label_price.text = str(item['price']) 

func _on_item_button_pressed():
	shop_slot_selected.emit(item)
