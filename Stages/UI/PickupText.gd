extends Control

# Add a variable to hold the text
var text_to_display: String

func set_text(text: String):
	text_to_display = text
	get_node("Label").text = text_to_display

func _ready():
	# Start the animation
	get_node("AnimationPlayer").play("process")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "process":
		queue_free()  # Remove the node after the animation finishes
