extends Control
class_name InventorySlot

@onready var icon = $ItemIcon
@onready var label_qty = $ItemQty
@onready var item_button = $ItemButton

signal inventory_slot_selected

# Slot item
var item = null

func set_empty():
	icon.texture = null
	label_qty.text = ''

func set_item(new_item):
	item = new_item
	icon.texture = item['texture']
	label_qty.text = str(item['qty'])

func _on_item_button_pressed():
	inventory_slot_selected.emit()
