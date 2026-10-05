extends Node

var game_state: GameState
var is_paused: bool = false
var current_scene: String = "main"

func _ready() -> void:
    game_state = GameState.new()
    add_child(game_state)
    game_state.name = "GameState"
    set_process_input(true)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        toggle_pause()

func toggle_pause() -> void:
    is_paused = !is_paused
    get_tree().paused = is_paused
    var pause_menu = get_tree().root.get_node_or_null("PauseMenu")
    if pause_menu:
        pause_menu.visible = is_paused
    print("Game paused: %s" % is_paused)

func add_money(amount: float) -> void:
    game_state.money += amount
    print("Money: %s" % game_state.money)

func add_reputation(amount: float) -> void:
    game_state.reputation += amount
    print("Reputation: %s" % game_state.reputation)

func advance_time(hours: int = 1) -> void:
    game_state.current_hour += hours
    if game_state.current_hour >= 24:
        game_state.current_day += 1
        game_state.current_hour = 0
