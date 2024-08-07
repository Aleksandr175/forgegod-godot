extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health: float

func _ready():
	health = MAX_HEALTH

#attack: Attack
func damage(attack: Attack):
	print(attack.attack_force, get_parent())
	health -= attack.attack_force
	
	if health <= 0:
		get_parent().die()
	else:
		get_parent().get_damage()
