extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var time_manager: Node = $TimeManager
@onready var creation_screen: Control = $CharacterCreation

func _ready() -> void:
    if player:
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)
    if hud:
        hud.set_player(player)
        hud.set_world_time(time_manager)
    if creation_screen:
        creation_screen.visible = true
    
    # Simulated world loop state
    player.economy.player_money = 150.0
