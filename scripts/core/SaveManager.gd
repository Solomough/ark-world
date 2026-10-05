extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var time_manager: Node = $TimeManager
@onready var hud: CanvasLayer = $HUD

var save_manager: SaveManager
var quest_system: QuestSystem
var main_menu: CanvasLayer

func _ready() -> void:
    save_manager = SaveManager.new()
    add_child(save_manager)
    save_manager.name = "SaveManager"

    quest_system = QuestSystem.new()
    add_child(quest_system)
    quest_system.name = "QuestSystem"

    setup_runtime_ui()

    if player:
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)
        player.set("save_manager", save_manager)
        player.set("quest_system", quest_system)

    if hud:
        hud.set_player(player)
        hud.set_world_time(time_manager)
        hud.update_hud()

    if time_manager:
        time_manager.start_time = 7.0
        time_manager.game_speed = 12.0

    var saved_state = save_manager.load_game()
    if saved_state.is_empty():
        quest_system.start_default_quest()

func _process(_delta: float) -> void:
    if main_menu != null and main_menu.visible:
        return

func setup_runtime_ui() -> void:
    if main_menu == null:
        main_menu = load("res://scripts/ui/MainMenu.gd").new() if false else MainMenu.new()
        add_child(main_menu)
        main_menu.visible = true
        main_menu.start_requested.connect(_on_start_requested)
        main_menu.continue_requested.connect(_on_continue_requested)
        main_menu.new_game_requested.connect(_on_new_game_requested)

func _on_start_requested() -> void:
    if main_menu:
        main_menu.visible = false
    if quest_system:
        quest_system.start_default_quest()

func _on_continue_requested() -> void:
    var saved_state = save_manager.load_game()
    if saved_state.is_empty():
        print("No saved game found.")
        return
    if main_menu:
        main_menu.visible = false
    if player:
        player.position = Vector3(0.0, 1.2, 0.0)

func _on_new_game_requested() -> void:
    if save_manager:
        save_manager.save_game({
            "player_name": "Ayo",
            "money": 150.0,
            "reputation": 0.0,
            "day": 1,
            "hour": 7,
            "quest_state": "starter"
        })
    if main_menu:
        main_menu.visible = false
    if quest_system:
        quest_system.start_default_quest()
