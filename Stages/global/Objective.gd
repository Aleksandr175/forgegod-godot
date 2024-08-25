extends Node

class_name Objective

var description: String
var target_amount: int = 1
var current_amount: int = 0
var is_done: bool = false
var type: String  # "craft", "collect", "visit", "buy"

func is_completed() -> bool:
	return current_amount >= target_amount

func progress(amount: int):
	current_amount += amount
	if current_amount >= target_amount:
		is_done = true
		print("Objective completed: ", description)
