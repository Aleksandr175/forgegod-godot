extends Node2D

var inventory_size = 20

var inventory_dictionary: Dictionary = {
	# Resources id from 1
	"coin": {
		"id": 1,
		"name": "Coin",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/coin.png"),
		"value": 1,
	},
	"wood": {
		"id": 2,
		"name": "Wood",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-wood.png"),
		"value": 1,
	},
	"iron": {
		"id": 3,
		"name": "Iron",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-iron.png"),
		"value": 3,
	},
	"copper": {
		"id": 4,
		"name": "Copper",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-copper.png"),
		"value": 2
	},
	
	"emerald": {
		"id": 5,
		"name": "Emerald",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-emerald.png"),
		"value": 15
	},

	"twilightite": {
		"id": 6,
		"name": "Twilightite",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-twilightite.png"),
		"value": 25
	},
	

	"copperIngot": {
		"id": 15,
		"name": "Copper Ingot",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-copper-ingot.png"),
		"value": 5
	},

	"ironIngot": {
		"id": 16,
		"name": "Iron Ingot",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/resources/resource-iron-ingot.png"),
		"value": 7
	},

	#"steelIngot": {
	#	"id": 17,
	#	"name": "Steel Ingot",
	#	"type": "Resource",
	#	"texture": load("res://assets/sprites/objects/resources/resource-iron-ingot.png"),
	#	"value": 20
	#},

	#"emeraldIngot": {
	#	"id": 18,
	#	"name": "Emerald Ingot",
	#	"type": "Resource",
	#	"texture": load("res://assets/sprites/objects/resources/resource-emerald-ingot.png"),
	#	"value": 25
	#},

	# Iron id from 100
	"swordWooden": {
		"id": 100,
		"name": "Wooden Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/swordWood.png"),
		"value": 8
	},
	"axeWooden": {
		"id": 101,
		"name": "Wooden Axe",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/axeWood.png"),
		"value": 7
	},
	"spearWooden": {
		"id": 102,
		"name": "Wooden Spear",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/spearWood.png"),
		"value": 5
	},

	# Iron id from 200
	"swordIron": {
		"id": 201,
		"name": "Iron Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/swordIron.png"),
		"value": 30,
	},
	"axeIron": {
		"id": 202,
		"name": "Iron Axe",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/axeIron.png"),
		"value": 25,
	},
	"spearIron": {
		"id": 203,
		"name": "Iron Spear",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/spearIron.png"),
		"value": 15,
	},
	"broadswordIron": {
		"id": 204,
		"name": "Iron Broadsword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/broadswordIron.png"),
		"value": 40,
	},
	"doubleBitAxeIron": {
		"id": 205,
		"name": "Iron Double Bit Axe",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/doubleBitAxeIron.png"),
		"value": 150,
	},
	
	# Steel id from 300
	"broadswordSteel": {
		"id": 302,
		"name": "Steel Broadsword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/broadswordSteel.png"),
		"value": 150,
	},

	"doubleBitAxeSteel": {
		"id": 303,
		"name": "Steel Double Bit Axe",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/doubleBitAxeSteel.png"),
		"value": 150,
	},
	
	"longswordSteel": {
		"id": 304,
		"name": "Steel Longsword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/longswordSteel.png"),
		"value": 180,
	},
	

	
	# Emerald id from 400
	"spearEmerald": {
		"id": 401,
		"name": "Emerald Spear",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/spearEmerald.png"),
		"value": 50,
	},
	"maceEmerald": {
		"id": 402,
		"name": "Emerald Mace",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/maceEmerald.png"),
		"value": 70,
	},
	"staffEmerald": {
		"id": 403,
		"name": "Emerald Staff",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/staffEmerald.png"),
		"value": 55,
	},

	"twilightiteSword": {
		"id": 501,
		"name": "Twilight Blade",
		"type": "Resource",
		"texture": load("res://assets/sprites/objects/goods/swordTwilightite.png"),
		"value": 150
	},


	"tearOfTheHeavens": {
		"id": 1001,
		"name": "Tear Of The Heavens",
		"type": "item",
		"texture": load("res://assets/sprites/objects/resources/resource-tearheavens.png"),
		"value": 3000,
	},

	"mountainsHeart": {
		"id": 1002,
		"name": "Mountain's Heart",
		"type": "item",
		"texture": load("res://assets/sprites/objects/resources/resource-mountainsHeart.png"),
		"value": 4000,
	},

	"breathForest": {
		"id": 1003,
		"name": "Breath of the Forest",
		"type": "item",
		"texture": load("res://assets/sprites/objects/resources/resource-breathForest.png"),
		"value": 3500,
	},

	"magicalPotion": {
		"id": 2000,
		"name": "Magical Potion",
		"type": "item",
		"texture": load("res://assets/sprites/objects/resources/resource-magicalPotion.png"),
		"value": 100,
	},
	
	"legendarySword": {
		"id": 3000,
		"name": "Legendary Sword",
		"type": "item",
		"texture": load("res://assets/sprites/objects/goods/legendarySword.png"),
		"value": 10000,
	},
	
	#"swordCopper": {
	#	"id": 102,
	#	"name": "Copper Sword",
	#	"type": "item",
	#	"texture": load("res://assets/sprites/objects/goods/swordCopper.png"),
	#	"value": 10,
	#},
}

var inventory_items: Array = [{
	"id": inventory_dictionary["coin"]["id"], 
	"qty": 50, 
	"name": inventory_dictionary["coin"]["name"], 
	"type": inventory_dictionary["coin"]["type"], 
	"texture": inventory_dictionary["coin"]["texture"],
	"scene_path": "res://scenes/objects/inventory_item.tscn" 
}]

var shop_items: Array = [{
	"id": inventory_dictionary["wood"]["id"],
	"name": inventory_dictionary["wood"]["name"],
	"texture": inventory_dictionary["wood"]["texture"],
	"price": inventory_dictionary["wood"]["value"],
	"type": "Resource"
}, {
	"id": inventory_dictionary["iron"]["id"],
	"name": inventory_dictionary["iron"]["name"],
	"texture": inventory_dictionary["iron"]["texture"],
	"price": inventory_dictionary["iron"]["value"],
	"type": "Resource"
}, {
	"id": inventory_dictionary["copper"]["id"],
	"name": inventory_dictionary["copper"]["name"],
	"texture": inventory_dictionary["copper"]["texture"],
	"price": inventory_dictionary["copper"]["value"],
	"type": "Resource",
}]


var unlocked_recipes: Array = []  # Stores IDs of unlocked recipes
var default_unlocked_recipes: Array = [inventory_dictionary["axeWooden"]["id"]]

var recipes: Array = [{
	"id": inventory_dictionary["copperIngot"]["id"],
	"name": inventory_dictionary["copperIngot"]["name"],
	"texture": inventory_dictionary["copperIngot"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": false,
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["copper"]["id"], 
		"name": inventory_dictionary["copper"]["name"], 
		"type": inventory_dictionary["copper"]["type"], 
		"texture": inventory_dictionary["copper"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["ironIngot"]["id"],
	"name": inventory_dictionary["ironIngot"]["name"],
	"texture": inventory_dictionary["ironIngot"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": false,
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["iron"]["id"], 
		"name": inventory_dictionary["iron"]["name"], 
		"type": inventory_dictionary["iron"]["type"], 
		"texture": inventory_dictionary["iron"]["texture"],
		"qty": 1,
	}],
}, 

# WOODEN WEAPONS
{
	"id": inventory_dictionary["spearWooden"]["id"],
	"name": inventory_dictionary["spearWooden"]["name"],
	"texture": inventory_dictionary["spearWooden"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 2,
	}],
}, {
	"id": inventory_dictionary["swordWooden"]["id"],
	"name": inventory_dictionary["swordWooden"]["name"],
	"texture": inventory_dictionary["swordWooden"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 4,
	}],
}, {
	"id": inventory_dictionary["axeWooden"]["id"],
	"name": inventory_dictionary["axeWooden"]["name"],
	"texture": inventory_dictionary["axeWooden"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": false,
	"requirements": [{
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 3,
	}],
}, 


# IRON WEAPONS
{
	"id": inventory_dictionary["spearIron"]["id"],
	"name": inventory_dictionary["spearIron"]["name"],
	"texture": inventory_dictionary["spearIron"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["axeIron"]["id"],
	"name": inventory_dictionary["axeIron"]["name"],
	"texture": inventory_dictionary["axeIron"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 2,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["swordIron"]["id"],
	"name": inventory_dictionary["swordIron"]["name"],
	"texture": inventory_dictionary["swordIron"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 3,
	}],
}, {
	"id": inventory_dictionary["broadswordIron"]["id"],
	"name": inventory_dictionary["broadswordIron"]["name"],
	"texture": inventory_dictionary["broadswordIron"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 5,
	}],
},

# STEEL WEAPONS
{
	"id": inventory_dictionary["broadswordSteel"]["id"],
	"name": inventory_dictionary["broadswordSteel"]["name"],
	"texture": inventory_dictionary["broadswordSteel"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 2,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["doubleBitAxeSteel"]["id"],
	"name": inventory_dictionary["doubleBitAxeSteel"]["name"],
	"texture": inventory_dictionary["doubleBitAxeSteel"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 3,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
},
{
	"id": inventory_dictionary["longswordSteel"]["id"],
	"name": inventory_dictionary["longswordSteel"]["name"],
	"texture": inventory_dictionary["longswordSteel"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["ironIngot"]["id"], 
		"name": inventory_dictionary["ironIngot"]["name"], 
		"type": inventory_dictionary["ironIngot"]["type"], 
		"texture": inventory_dictionary["ironIngot"]["texture"],
		"qty": 4,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
},

# EMERALD WEAPONS
{
	"id": inventory_dictionary["spearEmerald"]["id"],
	"name": inventory_dictionary["spearEmerald"]["name"],
	"texture": inventory_dictionary["spearEmerald"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["emerald"]["id"], 
		"name": inventory_dictionary["emerald"]["name"], 
		"type": inventory_dictionary["emerald"]["type"], 
		"texture": inventory_dictionary["emerald"]["texture"],
		"qty": 2,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["maceEmerald"]["id"],
	"name": inventory_dictionary["maceEmerald"]["name"],
	"texture": inventory_dictionary["maceEmerald"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["emerald"]["id"], 
		"name": inventory_dictionary["emerald"]["name"], 
		"type": inventory_dictionary["emerald"]["type"], 
		"texture": inventory_dictionary["emerald"]["texture"],
		"qty": 3,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 1,
	}],
}, {
	"id": inventory_dictionary["staffEmerald"]["id"],
	"name": inventory_dictionary["staffEmerald"]["name"],
	"texture": inventory_dictionary["staffEmerald"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["emerald"]["id"], 
		"name": inventory_dictionary["emerald"]["name"], 
		"type": inventory_dictionary["emerald"]["type"], 
		"texture": inventory_dictionary["emerald"]["texture"],
		"qty": 2,
	}, {
		"id": inventory_dictionary["wood"]["id"], 
		"name": inventory_dictionary["wood"]["name"], 
		"type": inventory_dictionary["wood"]["type"], 
		"texture": inventory_dictionary["wood"]["texture"],
		"qty": 2,
	}],
},

# TWILIGHTITE
{
	"id": inventory_dictionary["twilightiteSword"]["id"],
	"name": inventory_dictionary["twilightiteSword"]["name"],
	"texture": inventory_dictionary["twilightiteSword"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["twilightite"]["id"], 
		"name": inventory_dictionary["twilightite"]["name"], 
		"type": inventory_dictionary["twilightite"]["type"], 
		"texture": inventory_dictionary["twilightite"]["texture"],
		"qty": 4,
	}],
},

# LEGENDARY SWORD
{
	"id": inventory_dictionary["legendarySword"]["id"],
	"name": inventory_dictionary["legendarySword"]["name"],
	"texture": inventory_dictionary["legendarySword"]["texture"],
	"qty": 1,
	"type": "recipe",
	"locked": true,
	"requirements": [{
		"id": inventory_dictionary["tearOfTheHeavens"]["id"], 
		"name": inventory_dictionary["tearOfTheHeavens"]["name"], 
		"type": inventory_dictionary["tearOfTheHeavens"]["type"], 
		"texture": inventory_dictionary["tearOfTheHeavens"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["mountainsHeart"]["id"], 
		"name": inventory_dictionary["mountainsHeart"]["name"], 
		"type": inventory_dictionary["mountainsHeart"]["type"], 
		"texture": inventory_dictionary["mountainsHeart"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["breathForest"]["id"], 
		"name": inventory_dictionary["breathForest"]["name"], 
		"type": inventory_dictionary["breathForest"]["type"], 
		"texture": inventory_dictionary["breathForest"]["texture"],
		"qty": 1,
	}, {
		"id": inventory_dictionary["magicalPotion"]["id"], 
		"name": inventory_dictionary["magicalPotion"]["name"], 
		"type": inventory_dictionary["magicalPotion"]["type"], 
		"texture": inventory_dictionary["magicalPotion"]["texture"],
		"qty": 1,
	}],
},]

signal inventory_updated

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene: PackedScene = preload("res://UI/InventoryUI/Inventory_Slot.tscn")
@onready var recipe_slot_scene: PackedScene = preload("res://UI/RecipesUI/Recipe_Slot.tscn")
@onready var shop_slot_scene: PackedScene = preload("res://UI/ShopUI/Shop_Slot.tscn")
@onready var inventory_slot_small_scene: PackedScene = preload("res://UI/InventoryUI/Inventory_Slot_Small.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.new_game_started.connect(load_inventory)
	GlobalSignals.game_loaded.connect(load_inventory)
	load_inventory()
	
func reset_inventory():
	inventory_items.clear()
	# Ensure inventory_items has the correct size
	inventory_items.resize(inventory_size)
	inventory_updated.emit()
	
func add_item(item_id: int, qty: int) -> void:
	var item_dictionary = find_dictionary_item_by_id(item_id)
	var item_found = false
	
	# Check if the item already exists in the inventory
	for i in range(inventory_items.size()):
		var item = inventory_items[i]
		if item != null and item.id == item_dictionary.id:
			# Item found, increase quantity
			item.qty += qty
			inventory_items[i] = item
			item_found = true
			break

	# If item was not found, find the first empty slot to add the new item
	if not item_found:
		for i in range(inventory_items.size()):
			if inventory_items[i] == null:
				inventory_items[i] = item_dictionary
				inventory_items[i].qty = qty
				item_found = true
				break

	# Sort inventory to remove empty slots
	sort_inventory_items()
	
	# Save inventory to GameState
	save_inventory()
	GameState.save_game()

	# Emit signal after adding/updating the item
	inventory_updated.emit()
	
func remove_item(item: Dictionary) -> void:
	for i in range(inventory_items.size()):
		var inventory_item = inventory_items[i]

		if inventory_item and inventory_item.id == item.id:
			inventory_item.qty -= int(item.qty)
			if inventory_item.qty <= 0:
				# mark inventory item as empty
				inventory_items[i] = null
			break

	# Sort inventory to remove empty slots
	sort_inventory_items()
	
	# Save inventory to GameState
	save_inventory()
	GameState.save_game()

	inventory_updated.emit()

func set_player_reference(player: Node) -> void:
	player_node = player
	
func has_required_items(requirements: Array) -> bool:
	for requirement in requirements:
		var found = false
		# Check if the inventory contains the required item with sufficient quantity
		for inventory_item in Inventory.inventory_items:
			if inventory_item and inventory_item.name == requirement.name and int(inventory_item.qty) >= int(requirement.qty):
				found = true
				break
		# If any requirement is not met, return false
		if not found:
			return false
	return true

func remove_items(items: Array) -> void:
	# Reduce the quantity of each required item from the inventory
	for item in items:
		Inventory.remove_item(item)

func find_dictionary_item_by_id(itemId: int):
	for inventory_item in Inventory.inventory_dictionary:
		if Inventory.inventory_dictionary[inventory_item]["id"] == itemId:
			return Inventory.inventory_dictionary[inventory_item].duplicate(true)  # Return a deep copy of the item
	return null

func find_dictionary_item_by_name(item_name: String):
	for inventory_item in Inventory.inventory_dictionary:
		if Inventory.inventory_dictionary[inventory_item]["name"] == item_name:
			return Inventory.inventory_dictionary[inventory_item].duplicate(true)  # Return a deep copy of the item
	return null

func find_recipe_by_id(itemId: int):
	for inventory_item in Inventory.recipes:
		if inventory_item["id"] == itemId:
			return inventory_item.duplicate(true)  # Return a deep copy of the item
	return null
	
func find_item_in_inventory(item):
	for inventory_item in Inventory.inventory_items:
		if inventory_item and inventory_item.id == item.id:
			return inventory_item.duplicate(true)  # Return a deep copy of the item
	return null

func has_enought_coins(needed: int) -> bool:
	var coins = find_item_in_inventory(Inventory.inventory_dictionary["coin"])
	return coins and coins.qty >= needed

func has_enough_resources(resources: Array) -> bool:
	var enough_resources = true

	for resource in resources:
		var resource_in_inventory = find_item_in_inventory(resource)
		var qty = 0

		if resource_in_inventory != null:
			qty = resource_in_inventory.qty

		if qty < resource.qty:
			enough_resources = false
			break

	return enough_resources

func sort_inventory_items() -> void:
	# Remove null entries
	var compacted_items = []
	for item in inventory_items:
		if item != null:
			compacted_items.append(item)
	# Resize to inventory_size, filling with nulls if necessary
	compacted_items.resize(inventory_size)
	inventory_items = compacted_items

func load_inventory():
	reset_inventory()
	
	# Load inventory items
	var index = 0
	for saved_item in GameState.player_inventory:
		var item_dictionary = find_dictionary_item_by_id(saved_item["id"])
		if item_dictionary != null:
			var new_item = item_dictionary.duplicate(true)
			new_item.qty = saved_item["qty"]
			inventory_items[index] = new_item
			index += 1
			if index >= inventory_size:
				break  # Prevent exceeding inventory size
		else:
			print("Item with ID %d not found in inventory_dictionary." % saved_item["id"])

	# Load unlocked recipes
	if GameState.unlocked_recipes:
		unlocked_recipes = GameState.unlocked_recipes.duplicate()
	else:
		unlocked_recipes = default_unlocked_recipes.duplicate() # default unlocked recipes

	# Update recipes' locked status based on unlocked_recipes
	update_recipe_lock_status()

func update_recipe_lock_status():
	for recipe in recipes:
		var found = false  # A flag to track if the recipe.id is found in unlocked_recipes
		for unlocked_id in unlocked_recipes:
			if unlocked_id == recipe.id:
				found = true
				break  # Exit the loop once you find a match

		if found:
			recipe.locked = false
		else:
			recipe.locked = true
	
	GlobalSignals.recipes_unlocked.emit()

func save_inventory():
	var simplified_inventory = []
	for item in inventory_items:
		if item != null:
			simplified_inventory.append({
				"id": item.id,
				"qty": item.qty
			})
	GameState.player_inventory = simplified_inventory
	GameState.unlocked_recipes = unlocked_recipes

func unlock_recipe(recipe_id):
	if not unlocked_recipes.has(recipe_id):
		unlocked_recipes.append(recipe_id)
		# Update the locked status of the recipe
		update_recipe_lock_status()
		# Save the updated unlocked recipes
		save_inventory()
		GameState.save_game()
		
		var recipe = find_recipe_by_id(recipe_id)
		GlobalSignals.resource_picked_up.emit('Recipe ' + recipe.name, 1)

		return true
	return false

func get_unlocked_recipes() -> Array:
	var unlocked_recipe_list = []
	for recipe in recipes:
		if not recipe.locked:
			unlocked_recipe_list.append(recipe)
	return unlocked_recipe_list
