extends Node2D

@export var recipe_id: String = ""
@onready var collect_sound = $CollectSound
@onready var node = $"."
@onready var area_2d = $Area2D

func _ready():
	# Connect the 'finished' signal of collect_sound
	collect_sound.connect("finished", _on_collect_sound_finished)

func _on_area_2d_area_entered(area):
	if not self.get_parent().visible or not self.visible:
		return  # Ignore interaction if the resource is not visible

	var player = area.get_parent()
	if player is Player:
		collect_recipe()

func collect_recipe():
	if recipe_id == "":
		print("Recipe ID not set.")
		return

	print('play sound')
	collect_sound.play()
	node.visible = false

	# Disable collision to prevent multiple pickups
	area_2d.set_deferred("monitoring", false)
	area_2d.set_collision_layer(0)
	area_2d.set_collision_mask(0)
	
	if Inventory.unlock_recipe(int(recipe_id)):
		provide_feedback()
		#queue_free()
	else:
		print("Recipe already unlocked or could not unlock recipe.")

func _on_collect_sound_finished():
	print('remove recipe from scene')
	# Remove the coin from the scene
	queue_free()

func provide_feedback():
	pass
	# Play a sound effect
	#var sound = preload("res://Sounds/recipe_collected.wav")
	#sound.play()

	# Show a message to the player
	#UIManager.show_message("You've unlocked a new recipe!")

	# Optional: Play an animation
	#var animation_player = get_node("AnimationPlayer")
	#if animation_player:
	#	animation_player.play("Collect")
