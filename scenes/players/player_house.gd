extends CharacterBody2D
class_name PlayerHouse

const SPEED = 130.0
@onready var animated_sprite = $AnimatedSpritePlayer

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	var direction_vertical = Input.get_axis("move_up", "move_down")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_vertical:
		velocity.y = direction_vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	update_animations(direction, direction_vertical)
	move_and_slide()
	
	
func update_animations(direction: int, direction_vertical: int):
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

	# Flip the Sprite
	# TODO: improve animations, it turns right if we goes down-left
	if direction > 0 or direction_vertical > 0:
		animated_sprite.flip_h = false
	elif direction < 0 or direction_vertical < 0:
		animated_sprite.flip_h = true
