extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var time_manager: Node = $TimeManager
@onready var hud: CanvasLayer = $HUD

var save_manager: Node
var quest_system: Node
var dialogue_system: DialogueSystem
var trade_ui: TradeUI
var character_creation_ui: CharacterCreationUI
var market_stalls: Array = []
var farms: Array = []

func _ready() -> void:
    # Initialize core systems
    save_manager = Node.new()
    add_child(save_manager)
    save_manager.name = "SaveManager"

    quest_system = Node.new()
    add_child(quest_system)
    quest_system.name = "QuestSystem"

    dialogue_system = DialogueSystem.new()
    add_child(dialogue_system)
    dialogue_system.name = "DialogueSystem"

    trade_ui = TradeUI.new()
    add_child(trade_ui)
    trade_ui.name = "TradeUI"

    character_creation_ui = CharacterCreationUI.new()
    add_child(character_creation_ui)
    character_creation_ui.name = "CharacterCreationUI"
    character_creation_ui.set_on_complete(Callable(self, "_on_character_created"))

    # Setup player references
    if player:
        player.set("interaction_label", $HUD/InteractionLabel)
        player.set("world_time", time_manager)
        player.set("save_manager", save_manager)
        player.set("quest_system", quest_system)
        player.set("dialogue_system", dialogue_system)

    # Setup HUD
    if hud:
        hud.set_player(player)
        hud.set_world_time(time_manager)
        hud.update_hud()

    # Setup time manager
    if time_manager:
        time_manager.start_time = 7.0
        time_manager.game_speed = 12.0

    # Setup market stalls (add to world)
    var market_stall = MarketStall.new()
    market_stall.stall_position = Vector3(-8, 0, 0)
    market_stall.stall_name = "Amina's Market"
    market_stall.vendor_name = "Amina"
    add_child(market_stall)
    market_stalls.append(market_stall)

    # Setup farms (add to world)
    var farm = FarmInteraction.new()
    farm.farm_position = Vector3(12, 0, 8)
    farm.farm_name = "Community Garden"
    farm.plot_count = 4
    add_child(farm)
    if player:
        farm.set_player_inventory(player.inventory)
    farms.append(farm)

    # Character creation starts the game flow
    character_creation_ui.visible = true

func _on_character_created(char_data: Dictionary) -> void:
    print("Character created: %s" % char_data["name"])
    if player:
        player.economy.player_money = 150.0
    character_creation_ui.visible = false
    start_game()

func start_game() -> void:
    if quest_system and quest_system.has_method("start_default_quest"):
        quest_system.start_default_quest()
    print("Game started!")

func _process(_delta: float) -> void:
    pass
