extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ATTACK_DURATION = 0.5 # Duration of the attack animation in seconds
const ROTATION_INCREMENT = deg_to_rad(15) # 45 degrees in radians

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon_sprite = $WeaponSprite

var attack_timer = 0.0
	
func _ready():
	weapon_sprite.play("idle")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	#else:
	#	animated_sprite.play("jump")
		
	# Handle weapon attack
#	if Input.is_action_just_pressed("attack"):
#		weapon_sprite.play("attack")
#		attack_timer = ATTACK_DURATION
#		weapon_sprite.rotation = 45
	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func _on_weapon_sprite_animation_finished():
	weapon_sprite.play("idle")
	weapon_sprite.rotation = 0


func _on_weapon_sprite_frame_changed():
	# Calculate the rotation based on the remaining attack time
	# Rotate the weapon by 45 degrees each frame
	if weapon_sprite.animation == "attack":
		weapon_sprite.rotation += ROTATION_INCREMENT

