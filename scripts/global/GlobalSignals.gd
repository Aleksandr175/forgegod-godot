extends Node

signal player_entered_portal
signal player_exited_portal

signal inventory_opened
signal inventory_closed

signal craft_menu_opened
signal craft_menu_closed

signal craft_game_opened(recipe)
signal craft_game_closed

signal craft_game_dot_pressed(dot_node)

signal recipes_unlocked

signal resource_picked_up

signal start_dialog(dialog)
signal close_dialog

signal level_completed(level_name)
signal level_unlocked(level_name)

signal new_game_started
signal game_loaded

signal stage_changed
