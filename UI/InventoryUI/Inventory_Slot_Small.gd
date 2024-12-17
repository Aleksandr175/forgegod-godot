extends Control
class_name InventorySlotSmall

@onready var icon = $InnerBorder/ItemIcon
@onready var label_qty = $InnerBorder/ItemQty

signal invetory_slot_selected

# Slot item
var item = null

func set_empty():
	icon.texture = null
	label_qty.text = ''

func set_item(new_item):
	#print('new_item', new_item)
	item = new_item
	icon.texture = item['texture']
	label_qty.text = str(item['qty'])
