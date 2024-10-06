extends Node

var current_scene: Node = null
var is_transitioning: bool = false

var loading_screen: CanvasLayer = null

func _ready():
	# Load the loading screen scene
	var loading_screen_scene = preload("res://Stages/global/LoadingScreen.tscn")
	loading_screen = loading_screen_scene.instantiate()
	loading_screen.visible = false  # Hide initially
	add_child(loading_screen)  # Add it to the SceneManager node

	# Optional: Initialize the current_scene if needed
	current_scene = get_tree().current_scene

func change_scene(scene_path: String):
	if is_transitioning:
		return  # Prevent multiple transitions at the same time

	is_transitioning = true

	# Save the current scene path to GameState
	GameState.save_scene(scene_path)

	# Start the transition
	_start_transition(scene_path)

func _start_transition(scene_path: String):
	# Show transition animation or loading screen
	_show_loading_screen()
	print('loading')
	# Defer the actual scene change to allow the loading screen to display
	#await get_tree().process_frame

	# Optional: If you have a fade-out animation, you can yield until it's complete

	# Change the scene
	_replace_current_scene(scene_path)

	# Optional: Wait for the new scene to load and process
	#yield(get_tree(), "idle_frame")  # Wait for the scene to be ready

	# Hide the loading screen or play fade-in animation
	_hide_loading_screen()

	is_transitioning = false
	
func _replace_current_scene(scene_path: String):
	# Free the existing scene
	if current_scene:
		current_scene.call_deferred("free")

	# Load the new scene
	var new_scene = load(scene_path).instantiate()

	# Add the new scene to the scene tree
	get_tree().root.add_child(new_scene)

	# Set the new scene as the current scene
	get_tree().current_scene = new_scene
	current_scene = new_scene

func _show_loading_screen():
	loading_screen.visible = true
	var animation_player = loading_screen.get_node("AnimationPlayer")
	#animation_player.play("FadeIn")

func _hide_loading_screen():
	var animation_player = loading_screen.get_node("AnimationPlayer")
	#animation_player.play("FadeOut")
	#yield(animation_player, "animation_finished")
	loading_screen.visible = false
