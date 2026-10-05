extends Node

class_name EconomySystem

var player_money: float = 0.0
var prices: Dictionary = {
    "seed_maize": 10.0,
    "seed_tomato": 8.0,
    "tool_hoe": 25.0,
    "maize": 15.0,
    "tomato": 12.0,
    "vegetable": 10.0
}

func get_price(item_id: String) -> float:
    return prices.get(item_id, 1.0)

func get_player_money() -> float:
    return player_money
