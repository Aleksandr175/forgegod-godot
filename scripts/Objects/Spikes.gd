extends Node2D

func _on_kill_area_area_entered(area):
	if area.get_parent() is Player:
		print('die on spikes')
		area.get_parent().die()
