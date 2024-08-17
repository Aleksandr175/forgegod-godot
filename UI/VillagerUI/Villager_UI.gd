extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	# TODO: check inventory items
	# send signal about buying to send villager away and remove his wish
	pass # Replace with function body.

func update_panel(wish):
	print('update_wish', wish)
