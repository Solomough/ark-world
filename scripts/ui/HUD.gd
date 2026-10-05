extends CharacterBody3D

@export var move_speed := 4.0
@export var sprint_speed := 7.0
@export var jump_velocity := 5.5
@export var gravity := 18.0
@export var interaction_distance := 3.5

var current_speed: float
var stamina: float = 100.0
var interact_target: Node3D = null
var interaction_label: Label
var world_time: Node
var inventory: Node
var economy: Node
var skill_system: Node

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D

func _ready() -> void:
    current_speed = move_speed

    inventory = InventorySystem.new()
    add_child(inventory)
    inventory.name = "InventorySystem"

    economy = EconomySystem.new()
    add_child(economy)
    economy.name = "EconomySystem"
    economy.player_money = 150.0

    skill_system = SkillSystem.new()
    add_child(skill_system)
    skill_system.name = "SkillSystem"

    if interaction_label == null:
        var parent = get_parent()
        if parent and parent.has_node("HUD") and parent.get_node("HUD").has_node("InteractionLabel"):
            interaction_label = parent.get_node("HUD/InteractionLabel")
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        rotate_y(deg_to_rad(-event.relative.x * 0.2))
        camera_pivot.rotate_x(deg_to_rad(-event.relative.y * 0.15))
        camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -1.2, 0.8)

    if event.is_action_pressed("interact"):
        if interact_target != null:
            if interact_target.has_method("talk_to"):
                var dialog = interact_target.talk_to()
                if interaction_label:
                    interaction_label.text = "[%s] %s" % [dialog["name"], dialog["greeting"]]
                    await get_tree().create_timer(3.0).timeout
                    interaction_label.text = ""

func _physics_process(delta: float) -> void:
    var input_vector = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction = Vector3(input_vector.x, 0, input_vector.y)

    if direction.length() > 0.0:
        direction = direction.rotated(Vector3.UP, rotation.y)
        var target_velocity = direction.normalized() * current_speed
        velocity.x = target_velocity.x
        velocity.z = target_velocity.z
    else:
        velocity.x = move_toward(velocity.x, 0.0, 14.0)
        velocity.z = move_toward(velocity.z, 0.0, 14.0)

    if not is_on_floor():
        velocity.y -= gravity * delta
    elif Input.is_action_just_pressed("jump"):
        velocity.y = jump_velocity

    if Input.is_action_pressed("sprint") and stamina > 0.0 and direction.length() > 0.1:
        current_speed = sprint_speed
        stamina = max(0.0, stamina - 22.0 * delta)
    else:
        current_speed = move_speed
        stamina = min(100.0, stamina + 18.0 * delta)

    move_and_slide()
    update_interaction_target()
    update_hud()

func update_interaction_target() -> void:
    interact_target = null
    var closest_target: Node3D = null
    var closest_distance := INF

    for node in get_tree().get_nodes_in_group("npc"):
        if node is Node3D:
            var distance = global_position.distance_to(node.global_position)
            if distance < interaction_distance and distance < closest_distance:
                closest_distance = distance
                closest_target = node

    interact_target = closest_target

    if interaction_label:
        if interact_target != null:
            interaction_label.text = "[E] Interact with %s" % [interact_target.get("npc_name")]
        else:
            interaction_label.text = ""

func update_hud() -> void:
    var hud_node = get_parent().get_node_or_null("HUD")
    if hud_node == null:
        return
    if hud_node.has_method("set_player"):
        hud_node.set_player(self)
    if world_time and hud_node.has_method("set_world_time"):
        hud_node.set_world_time(world_time)

func get_inventory() -> Node:
    return inventory

func get_skills() -> Node:
    return skill_system
