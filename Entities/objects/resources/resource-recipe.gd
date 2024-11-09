extends Node2D

@export var recipe_id: String = ""

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

	if Inventory.unlock_recipe(int(recipe_id)):
		provide_feedback()
		queue_free()
	else:
		print("Recipe already unlocked or could not unlock recipe.")

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
