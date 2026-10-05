extends CanvasLayer

var world_time: Node
var player_ref: Node

@onready var time_label: Label = $TopBar/TimeLabel
@onready var money_label: Label = $TopBar/MoneyLabel
@onready var skill_label: Label = $TopBar/SkillLabel
@onready var interaction_label: Label = $InteractionLabel

func _ready() -> void:
    update_hud()

func _process(_delta: float) -> void:
    if world_time != null and world_time.has_method("get_time_string"):
        time_label.text = "Time: %s" % world_time.get_time_string()

    if player_ref != null:
        if player_ref.has_method("get_money"):
            money_label.text = "Ark Credits: %s" % str(int(player_ref.get_money()))
        if player_ref.has_method("get_skills"):
            var skills = player_ref.get_skills()
            if skills != null and skills.has_method("get_skill_level"):
                skill_label.text = "Agriculture: Lv. %d" % skills.get_skill_level("agriculture")

func set_world_time(node: Node) -> void:
    world_time = node

func set_player(node: Node) -> void:
    player_ref = node

func update_hud() -> void:
    if time_label:
        time_label.text = "Time: 07:00"
    if money_label:
        money_label.text = "Ark Credits: 150"
    if skill_label:
        skill_label.text = "Agriculture: Lv. 1"

func show_interaction(text: String) -> void:
    if interaction_label:
        interaction_label.text = text

func clear_interaction() -> void:
    if interaction_label:
        interaction_label.text = ""
