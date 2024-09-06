extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ATTACK_DURATION = 0.5 # Duration of the attack animation in seconds
const ROTATION_INCREMENT = deg_to_rad(45) # 45 degrees in radians
@onready var timer = $Timer
@export var DAMAGE = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSpritePlayer
@onready var weapon_sprite = $WeaponSprite

@onready var inventory_ui = $InventoryUI

@export var attacking = false
@export var auto_attacking = false
var dying = false;
var direction = 0;
var direction_vertical = 0;
var last_direction = 1
var is_climbing = false
var can_move = true

func _ready():
	GameManager.player = self
	weapon_sprite.play("idle")
	weapon_sprite.visible = false
	change_weapon_position()
	Inventory.set_player_reference(self)
	
func _process(_delta):
	if Input.is_action_just_pressed("attack") and !attacking:
		attack()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and !is_climbing:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_climbing:
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	direction = Input.get_axis("move_left", "move_right")

	# Get the input direction vertical: -1, 0, 1
	direction_vertical = Input.get_axis("move_up", "move_down")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction != last_direction and direction != 0:
		last_direction = direction
		change_weapon_position()
		attack_end()

	if is_climbing:
		# Handle climbing logic
		# Example: Move up or down based on input
		if direction_vertical:
			velocity.y = direction_vertical * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	if !dying and !get_tree().paused:
		update_animations(direction, is_climbing)
		if can_move:
			move_and_slide()
	
	if position.y > 300 && !dying:
		die()

func change_weapon_position():
	if !dying:
		weapon_sprite.position.x = 7 * last_direction
		weapon_sprite.rotation = deg_to_rad(30)
		weapon_sprite.rotation = weapon_sprite.rotation * last_direction

func update_animations(direction_value, is_climbing_value):
	# Play animations
	if is_on_floor() or is_climbing_value:
		if direction_value == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	if !can_move:
		animated_sprite.play("idle")

	# Flip the Sprite
	if direction_value > 0:
		animated_sprite.flip_h = false
	elif direction_value < 0:
		animated_sprite.flip_h = true
		
	if last_direction > 0:
		weapon_sprite.flip_h = false
	elif last_direction < 0:
		weapon_sprite.flip_h = true
		

func attack():
	weapon_sprite.rotation = 0
	attacking = true
	weapon_sprite.visible = true
	weapon_sprite.play("attack")

func attack_end():
	change_weapon_position()
	attacking = false
	weapon_sprite.visible = false
	weapon_sprite.play("idle")

func _on_weapon_sprite_animation_finished():
	attack_end()

	if auto_attacking:
		attack()
	
func _on_weapon_sprite_frame_changed():
	# Calculate the rotation based on the remaining attack time
	# Rotate the weapon by 15 degrees each frame
	if weapon_sprite.animation == "attack":
		weapon_sprite.rotation += (ROTATION_INCREMENT * last_direction)

func die():
	print("You died!", self, self.get_parent())
	Engine.time_scale = 0.5
	animated_sprite.play("die")
	dying = true
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1	

func _on_animated_sprite_player_animation_finished():
	if animated_sprite.animation == 'die':
		dying = false
		GameManager.respawn_player()

func _on_hitbox_component_area_entered(area):
	if area.has_method("damage") and attacking:
		var attack_data = Attack.new()
		attack_data.attack_force = DAMAGE

		print('damage', attack_data)
		area.damage(attack_data)

func start_climbing():
	is_climbing = true

func stop_climbing():
	is_climbing = false

func _input(event):
	if event.is_action_pressed("inventory_ui"):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused


func _on_inventory_panel_inventory_closed():
	inventory_ui.visible = !inventory_ui.visible
	get_tree().paused = !get_tree().paused

func auto_attack():
	attack()
	auto_attacking = true
	
func auto_attack_stop():
	auto_attacking = false

func move_stop():
	can_move = false

func move_start():
	can_move = true

func _on_tree_entered():
	GlobalSignals.player_entered_portal.connect(move_stop)
	pass # Replace with function body.


func _on_tree_exited():
	GlobalSignals.player_entered_portal.disconnect(move_stop)
	pass # Replace with function body.
