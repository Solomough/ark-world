extends Node

class_name InventorySystem

var inventory: Dictionary = {}
var max_weight: float = 50.0
var current_weight: float = 0.0

const ITEM_WEIGHTS = {
    "seed_maize": 0.1,
    "seed_tomato": 0.08,
    "maize": 0.5,
    "tomato": 0.3,
    "vegetable": 0.25,
    "wood": 2.0,
    "stone": 3.0,
    "metal": 2.5,
    "concrete": 4.0,
    "tool_hoe": 1.5,
    "tool_pickaxe": 2.0,
    "tool_axe": 1.8,
}

func _ready() -> void:
    # Start with some seeds
    add_item("seed_maize", 5)
    add_item("tool_hoe", 1)

func add_item(item_id: String, quantity: int = 1) -> bool:
    var weight = ITEM_WEIGHTS.get(item_id, 0.5)
    var total_weight = weight * quantity
    
    if current_weight + total_weight > max_weight:
        print("Inventory full!")
        return false
    
    if not inventory.has(item_id):
        inventory[item_id] = 0
    
    inventory[item_id] += quantity
    current_weight += total_weight
    return true

func remove_item(item_id: String, quantity: int = 1) -> bool:
    if not inventory.has(item_id) or inventory[item_id] < quantity:
        return false
    
    var weight = ITEM_WEIGHTS.get(item_id, 0.5)
    inventory[item_id] -= quantity
    current_weight -= weight * quantity
    
    if inventory[item_id] <= 0:
        inventory.erase(item_id)
    
    return true

func get_item_count(item_id: String) -> int:
    return inventory.get(item_id, 0)

func get_inventory_percentage() -> float:
    return (current_weight / max_weight) * 100.0

func get_all_items() -> Dictionary:
    return inventory.duplicate()
