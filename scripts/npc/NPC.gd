extends CharacterBody3D

@export var npc_name := "Guide"
@export var profession := "Teacher"
@export var walk_speed := 1.8
@export var home_position: Vector3 = Vector3.ZERO
@export var work_position: Vector3 = Vector3(6, 0, 3)

var state := "idle"
var target_position: Vector3 = Vector3.ZERO
var timer := 0.0

func _ready() -> void:
    add_to_group("npc")
    home_position = global_position
    target_position = work_position
    update_visual_state()

func _physics_process(delta: float) -> void:
    timer += delta
    if state == "idle":
        if timer > 2.0:
            state = "walking"
            target_position = work_position if global_position.distance_to(work_position) < 0.5 else work_position
            timer = 0.0
    elif state == "walking":
        var direction = target_position - global_position
        if direction.length() < 0.5:
            state = "idle"
            timer = 0.0
        else:
            direction.y = 0
            velocity.x = direction.normalized().x * walk_speed
            velocity.z = direction.normalized().z * walk_speed
            move_and_slide()
            look_at(Vector3(target_position.x, global_position.y, target_position.z), Vector3.UP)

func talk_to() -> Dictionary:
    return {
        "name": npc_name,
        "profession": profession,
        "greeting": "This place is growing. There is land. There is work. There are people building things."
    }

func update_visual_state() -> void:
    pass
