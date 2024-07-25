extends Node2D
class_name Slime

const SPEED = 30

var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSpriteSlime
var dying = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	if !dying:
		position.x += direction * SPEED * delta


func _on_kill_body_area_entered(area):
	if area.get_parent() is Player && !dying:
		print('die')
		area.get_parent().die()
		
func die():
	dying = true
	animated_sprite.play('die')

func _on_animated_sprite_slime_animation_finished():
	if animated_sprite.animation == 'die':
		queue_free()
