extends Node

class_name EconomySystem

var prices: Dictionary = {}
var npc_production: Dictionary = {}
var player_money: float = 150.0

const BASE_PRICES = {
    "maize": 12.0,
    "tomato": 15.0,
    "vegetable": 10.0,
    "seed_maize": 3.0,
    "seed_tomato": 4.0,
    "wood": 5.0,
    "stone": 4.0,
    "metal": 25.0,
    "concrete": 8.0,
    "tool_hoe": 45.0,
    "tool_pickaxe": 60.0,
    "tool_axe": 55.0,
}

func _ready() -> void:
    prices = BASE_PRICES.duplicate()
    initialize_npc_production()

func initialize_npc_production() -> void:
    npc_production = {
        "farmer": {"output": "maize", "amount_per_day": 5},
        "vendor": {"output": "seed_maize", "amount_per_day": 3},
        "builder": {"output": "wood", "amount_per_day": 8},
    }

func update_prices() -> void:
    # Simple supply/demand: if there's high production, price drops
    for item in prices.keys():
        var adjustment = randf_range(0.95, 1.05)  # 5% variance
        prices[item] = max(BASE_PRICES[item] * 0.5, prices[item] * adjustment)

func buy_item(item_id: String, quantity: int, from_player: bool = false) -> bool:
    var price = prices.get(item_id, 0.0)
    var total_cost = price * quantity
    
    if from_player:
        if player_money < total_cost:
            print("Not enough money!")
            return false
        player_money -= total_cost
        return true
    return false

func sell_item(item_id: String, quantity: int) -> float:
    var price = prices.get(item_id, 0.0)
    var total_revenue = price * quantity
    player_money += total_revenue
    return total_revenue

func get_price(item_id: String) -> float:
    return prices.get(item_id, 0.0)

func get_player_money() -> float:
    return player_money
