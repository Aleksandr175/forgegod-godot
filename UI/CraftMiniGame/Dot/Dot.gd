extends Control

signal dot_clicked

var is_clicked = false
@onready var particles = $CPUParticles2D
@onready var forge_sound = $ForgeSound

func _ready():
	particles.emitting = false

func _on_touch_screen_button_pressed():
	if not is_clicked:
		play_dot_animation(self)
		forge_sound.play()

		particles.emitting = true  # Start emitting particles
		
		# Optionally, you can stop emitting after a short delay
		await get_tree().create_timer(0.2).timeout
		particles.emitting = false

		is_clicked = true
		GlobalSignals.craft_game_dot_pressed.emit(self)

func play_dot_animation(dot_node):
	# Example using a Tween for a simple scale animation
	var tween = create_tween()
	tween.tween_property(dot_node, "scale", Vector2(2,2), 0.2)  # Scale up in 0.2s
	tween.tween_callback(Callable(self, "_remove_dot").bind(dot_node))
