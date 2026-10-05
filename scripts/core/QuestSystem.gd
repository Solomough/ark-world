extends Node

class_name QuestSystem

signal quest_updated

var active_quests: Dictionary = {}
var quest_log: Array = []

func _ready() -> void:
    start_default_quest()

func start_default_quest() -> void:
    var quest_id := "starter_guide"
    if active_quests.has(quest_id):
        return

    var quest := {
        "id": quest_id,
        "title": "Welcome to Ark World",
        "description": "Meet The Guide and learn the basics of work, land, and opportunity.",
        "objectives": [
            {"id": "talk_to_guide", "text": "Speak with The Guide", "done": false},
            {"id": "visit_market", "text": "Visit the market square", "done": false},
            {"id": "learn_basic_work", "text": "Learn the first opportunity path", "done": false}
        ],
        "reward": {"money": 50.0, "xp": 25},
        "completed": false
    }
    active_quests[quest_id] = quest
    quest_log.append(quest["title"])
    emit_signal("quest_updated")

func start_quest(quest_id: String) -> void:
    if active_quests.has(quest_id):
        return

    var quest := {
        "id": quest_id,
        "title": "Opportunity",
        "description": "A new chance has appeared in the settlement.",
        "objectives": [],
        "reward": {"money": 10.0, "xp": 10},
        "completed": false
    }
    active_quests[quest_id] = quest
    quest_log.append(quest["title"])
    emit_signal("quest_updated")

func complete_objective(quest_id: String, objective_id: String) -> void:
    if not active_quests.has(quest_id):
        return

    var quest = active_quests[quest_id]
    for objective in quest["objectives"]:
        if objective["id"] == objective_id:
            objective["done"] = true
            break

    if all_objectives_done(quest):
        quest["completed"] = true
        emit_signal("quest_updated")

func all_objectives_done(quest: Dictionary) -> bool:
    for objective in quest["objectives"]:
        if not objective["done"]:
            return false
    return true

func get_active_quests() -> Array:
    var result: Array = []
    for quest in active_quests.values():
        result.append(quest)
    return result

func has_active_quests() -> bool:
    return not active_quests.is_empty()

func get_current_quest_text() -> String:
    if active_quests.is_empty():
        return "No active quest"
    var quest = active_quests.values()[0]
    return quest["title"]
