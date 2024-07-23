extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ATTACK_DURATION = 0.5 # Duration of the attack animation in seconds
const ROTATION_INCREMENT = deg_to_rad(45) # 45 degrees in radians
@onready var timer = $Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSpritePlayer
@onready var weapon_sprite = $WeaponSprite
@onready var weapon_area = $WeaponSprite/WeaponArea2D

@export var attacking = false
var dying = false;

func _ready():
	GameManager.player = self
	weapon_sprite.play("idle")
	
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	#else:
	#	animated_sprite.play("jump")
		
	# Handle weapon attack
	#if Input.is_action_just_pressed("attack") and !weapon_sprite.animation == 'attack':
#		weapon_sprite.rotation = 0
#		weapon_sprite.play("attack")	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	update_animations(direction)
	move_and_slide()
	
	if position.y > 600 && !dying:
		die()
	
func update_animations(direction):
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
func attack():
	weapon_sprite.rotation = 0
	attacking = true
	weapon_sprite.play("attack")

func _on_weapon_sprite_animation_finished():
	weapon_sprite.play("idle")
	weapon_sprite.rotation = deg_to_rad(30)

func _on_weapon_sprite_frame_changed():
	# Calculate the rotation based on the remaining attack time
	# Rotate the weapon by 15 degrees each frame
	if weapon_sprite.animation == "attack":
		weapon_sprite.rotation += ROTATION_INCREMENT

func _on_weapon_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		print("Enemy hit!")

func die():
	print("You died!", self, self.get_parent())
	Engine.time_scale = 0.5
	dying = true
	timer.start()

func _on_timer_timeout():
	print('respawn')
	dying = false
	Engine.time_scale = 1.0
	GameManager.respawn_player()
