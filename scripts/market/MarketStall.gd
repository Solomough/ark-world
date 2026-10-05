extends Node3D

class_name MarketStall

@export var stall_name: String = "Market Stall"
@export var vendor_name: String = "Vendor"
@export var stall_position: Vector3 = Vector3.ZERO
@export var buy_items: Array = ["seed_maize", "seed_tomato", "tool_hoe"]
@export var sell_items: Array = ["maize", "tomato", "vegetable"]

var inventory: Dictionary = {}

func _ready() -> void:
    add_to_group("market_stall")
    global_position = stall_position
    initialize_inventory()

func initialize_inventory() -> void:
    for item in buy_items:
        inventory[item] = 10
    for item in sell_items:
        inventory[item] = 0

func can_buy_item(item_id: String, quantity: int) -> bool:
    return inventory.get(item_id, 0) >= quantity

func buy_from_player(item_id: String, quantity: int, player_economy: EconomySystem) -> bool:
    if not item_id in sell_items:
        return false
    if quantity <= 0:
        return false

    var price_per_item = player_economy.get_price(item_id)
    var total = price_per_item * quantity

    if player_economy.player_money < total:
        return false

    player_economy.player_money -= total
    inventory[item_id] = inventory.get(item_id, 0) + quantity
    return true

func sell_to_player(item_id: String, quantity: int, player_economy: EconomySystem) -> bool:
    if not item_id in buy_items:
        return false
    if not can_buy_item(item_id, quantity):
        return false

    var price_per_item = player_economy.get_price(item_id)
    var total = price_per_item * quantity

    player_economy.player_money += total
    inventory[item_id] -= quantity
    return true

func get_inventory() -> Dictionary:
    return inventory.duplicate()

func get_vendor_greeting() -> String:
    return "Welcome to %s. I have seeds, tools, and I'll buy your produce." % stall_name
