extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var interaction_label: Label = $HUD/InteractionLabel

func _ready() -> void:
    if player:
        player.set("interaction_label", interaction_label)
    update_world_ambience()

func update_world_ambience() -> void:
    var sky_color = Color(0.05, 0.10, 0.15)
    var env = get_viewport().get_camera_3d().get_environment()
    if env:
        env.background_color = sky_color
