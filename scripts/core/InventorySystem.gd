extends Node

class_name InventorySystem

var items: Dictionary = {}

func add_item(item_id: String, quantity: int = 1) -> void:
    items[item_id] = items.get(item_id, 0) + quantity

func remove_item(item_id: String, quantity: int = 1) -> bool:
    if items.get(item_id, 0) >= quantity:
        items[item_id] -= quantity
        if items[item_id] <= 0:
            items.erase(item_id)
        return true
    return false

func has_item(item_id: String, quantity: int = 1) -> bool:
    return items.get(item_id, 0) >= quantity

func get_item_count(item_id: String) -> int:
    return items.get(item_id, 0)
