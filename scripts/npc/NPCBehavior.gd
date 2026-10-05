extends CharacterBody3D

@export var npc_name := "Settler"
@export var profession := "Worker"
@export var walk_speed := 1.8
@export var home_position: Vector3 = Vector3.ZERO
@export var work_position: Vector3 = Vector3(6, 0, 3)

var schedule: NPCSchedule
var state := "idle"
var target_position: Vector3 = Vector3.ZERO
var timer := 0.0
var current_game_time: float = 7.0

func _ready() -> void:
    add_to_group("npc")
    home_position = global_position
    setup_schedule()
    target_position = work_position

func setup_schedule() -> void:
    schedule = NPCSchedule.new()
    # Morning: 7-12, work
    schedule.add_activity(7.0, 12.0, work_position, "work")
    # Afternoon: 12-17, work
    schedule.add_activity(12.0, 17.0, work_position, "work")
    # Evening: 17-21, home
    schedule.add_activity(17.0, 21.0, home_position, "rest")
    # Night: 21-7, home
    schedule.add_activity(21.0, 24.0, home_position, "sleep")
    schedule.add_activity(0.0, 7.0, home_position, "sleep")

func _physics_process(delta: float) -> void:
    timer += delta
    
    # Update target based on schedule
    if timer > 2.0:
        target_position = schedule.get_current_target(current_game_time)
        var activity = schedule.get_current_activity(current_game_time)
        state = "walking" if global_position.distance_to(target_position) > 0.5 else activity
        timer = 0.0
    
    if state == "walking":
        var direction = target_position - global_position
        if direction.length() < 0.5:
            state = "idle"
        else:
            direction.y = 0
            velocity.x = direction.normalized().x * walk_speed
            velocity.z = direction.normalized().z * walk_speed
            move_and_slide()
            look_at(Vector3(target_position.x, global_position.y, target_position.z), Vector3.UP)
    else:
        velocity = Vector3.ZERO
        move_and_slide()

func set_game_time(time: float) -> void:
    current_game_time = time

func talk_to() -> Dictionary:
    return {
        "name": npc_name,
        "profession": profession,
        "greeting": get_greeting_for_time(),
        "has_quest": false,
    }

func get_greeting_for_time() -> String:
    var activity = schedule.get_current_activity(current_game_time)
    match activity:
        "work":
            return "I'm working on something important right now."
        "rest":
            return "Good to see you. I'm relaxing for a bit."
        "sleep":
            return "It's late... I should get some rest."
        _:
            return "Hello there."
