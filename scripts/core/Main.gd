extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var time_manager: Node = $TimeManager
@onready var creation_screen: CanvasLayer = $CharacterCreation
@onready var guide: CharacterBody3D = $Guide
@onready var market_stall: Node3D = $MarketStall
@onready var farm: Node3D = $Farm

func _ready() -> void:
    # Setup player systems
    if player:
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)
        player.economy.player_money = 150.0

    # Setup HUD
    if hud:
        hud.set_player(player)
        hud.set_world_time(time_manager)
        hud.update_hud()

    # Setup time manager
    if time_manager:
        time_manager.start_time = 7.0
        time_manager.game_speed = 12.0

    # Show character creation
    if creation_screen:
        creation_screen.visible = true

func _process(_delta: float) -> void:
    pass
