extends Control

@onready var icon = $InnerBorder/ItemIcon
@onready var label_qty = $InnerBorder/ItemQty
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType

# Slot item
var item = null

func _on_item_button_mouse_entered():
	if item != null:
		details_panel.visible = true

func _on_item_button_mouse_exited():
	details_panel.visible = false

func set_empty():
	icon.texture = null
	label_qty.text = ''

func set_item(new_item):
	print('new_item', new_item)
	item = new_item
	icon.texture = item['texture']
	label_qty.text = str(item['qty'])
	item_name.text = str(item['name'])
	item_type.text = str(item['type'])
