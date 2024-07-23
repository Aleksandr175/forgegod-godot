extends Node2D
class_name Slime

const SPEED = 60

var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSpriteSlime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta


func _on_kill_body_area_entered(area):
	#print('entre', area, area.get_parent(), area.get_parent() is Player)
	if area.get_parent() is Player:
		print('die')
		area.get_parent().die()
