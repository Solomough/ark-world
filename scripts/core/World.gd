extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var time_manager: Node = $TimeManager
@onready var hud: CanvasLayer = $HUD

var save_manager: SaveManager
var quest_system: QuestSystem
var dialogue_system: DialogueSystem
var market_stalls: Array = []
var farms: Array = []

func _ready() -> void:
    save_manager = SaveManager.new()
    add_child(save_manager)
    save_manager.name = "SaveManager"

    quest_system = QuestSystem.new()
    add_child(quest_system)
    quest_system.name = "QuestSystem"

    dialogue_system = DialogueSystem.new()
    add_child(dialogue_system)
    dialogue_system.name = "DialogueSystem"

    if player:
        player.save_manager = save_manager
        player.quest_system = quest_system
        player.dialogue_system = dialogue_system
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)

    if hud:
        hud.set_player(player)
        hud.set_world_time(time_manager)
        hud.update_hud()

    if time_manager:
        time_manager.start_time = 7.0
        time_manager.game_speed = 12.0

    var market_stall = MarketStall.new()
    market_stall.stall_position = Vector3(-8, 0, 0)
    market_stall.stall_name = "Amina's Market"
    market_stall.vendor_name = "Amina"
    add_child(market_stall)
    market_stalls.append(market_stall)

    var farm = FarmInteraction.new()
    farm.farm_position = Vector3(12, 0, 8)
    farm.farm_name = "Community Garden"
    farm.plot_count = 4
    add_child(farm)
    if player and player.inventory:
        farm.set_player_inventory(player.inventory)
    farms.append(farm)

    if quest_system:
        quest_system.start_default_quest()

func _process(_delta: float) -> void:
    pass
