extends Node

class_name Objective

var description: String
var target_qty: int = 1
var current_qty: int = 0
var is_done: bool = false
var type: String  # "craft", "collect", "visit", "buy"
var item_id: int = 0

func is_completed() -> bool:
	return current_qty >= target_qty

func progress(qty: int):
	current_qty += qty
	if current_qty >= target_qty:
		is_done = true
		print("Objective completed: ", description)
