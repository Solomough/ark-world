extends Node

var save_version := 1
var player_name := "New Resident"
var money := 150.0
var reputation := 0.0
var current_day := 1
var current_hour := 7

func get_state() -> Dictionary:
    return {
        "save_version": save_version,
        "player_name": player_name,
        "money": money,
        "reputation": reputation,
        "current_day": current_day,
        "current_hour": current_hour
    }

func load_state(state: Dictionary) -> void:
    if state.is_empty():
        return
    if state.has("save_version"):
        save_version = int(state["save_version"])
    if state.has("player_name"):
        player_name = str(state["player_name"])
    if state.has("money"):
        money = float(state["money"])
    if state.has("reputation"):
        reputation = float(state["reputation"])
    if state.has("current_day"):
        current_day = int(state["current_day"])
    if state.has("current_hour"):
        current_hour = int(state["current_hour"])
