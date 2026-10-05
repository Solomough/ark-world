extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var time_manager: Node = $TimeManager
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
    if player:
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)

    if hud:
        hud.set("player_ref", player)
        hud.set("world_time", time_manager)
        hud.update_hud()

    if time_manager:
        time_manager.start_time = 7.0
        time_manager.game_speed = 12.0

func _process(_delta: float) -> void:
    pass
