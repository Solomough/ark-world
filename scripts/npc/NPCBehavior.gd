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
var dialogue_topics: Dictionary = {}
var has_spoken: bool = false

func _ready() -> void:
    add_to_group("npc")
    home_position = global_position
    setup_schedule()
    setup_dialogue()
    target_position = work_position

func setup_schedule() -> void:
    schedule = NPCSchedule.new()
    schedule.add_activity(7.0, 12.0, work_position, "work")
    schedule.add_activity(12.0, 17.0, work_position, "work")
    schedule.add_activity(17.0, 21.0, home_position, "rest")
    schedule.add_activity(21.0, 24.0, home_position, "sleep")
    schedule.add_activity(0.0, 7.0, home_position, "sleep")

func setup_dialogue() -> void:
    dialogue_topics = {
        "greeting": {
            "text": "Hello there. I'm %s, a %s." % [npc_name, profession],
            "choices": [
                {"text": "What do you do?", "next_dialogue": "profession"},
                {"text": "Any work available?", "next_dialogue": "work_opportunity"},
                {"text": "Goodbye.", "next_dialogue": "farewell"}
            ]
        },
        "profession": {
            "text": "I work as a %s here in the settlement. It's honest work." % profession,
            "choices": [
                {"text": "Back.", "next_dialogue": "greeting"}
            ]
        },
        "work_opportunity": {
            "text": "Yes, there's always something to do. Learn our skills and earn value.",
            "choices": [
                {"text": "I'm interested.", "action": {"type": "quest_complete", "quest_id": "starter_guide", "objective_id": "talk_to_guide"}},
                {"text": "Maybe later.", "next_dialogue": "greeting"}
            ]
        },
        "farewell": {
            "text": "Good luck out there.",
            "choices": []
        }
    }

func _physics_process(delta: float) -> void:
    timer += delta
    
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

func get_dialogue(topic: String) -> Dictionary:
    if dialogue_topics.has(topic):
        return dialogue_topics[topic]
    return dialogue_topics.get("greeting", {"text": "..."})

func talk_to() -> Dictionary:
    has_spoken = true
    return {
        "name": npc_name,
        "profession": profession,
        "greeting": get_dialogue("greeting")["text"],
        "has_quest": true,
    }
