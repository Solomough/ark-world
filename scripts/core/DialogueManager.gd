extends Node

class_name DialogueManager

var current_dialogue: Dictionary = {}
var is_dialogue_open: bool = false

func start_dialogue(npc_data: Dictionary) -> void:
    current_dialogue = npc_data
    is_dialogue_open = true
    print("Starting dialogue with %s" % npc_data.get("name", "Unknown"))

func get_greeting() -> String:
    return current_dialogue.get("greeting", "Hello.")

func get_profession_info() -> String:
    return "I am a %s" % current_dialogue.get("profession", "settler")

func close_dialogue() -> void:
    is_dialogue_open = false
    current_dialogue = {}

func can_offer_quest() -> bool:
    return current_dialogue.get("has_quest", false)

func get_available_quests() -> Array:
    return current_dialogue.get("quests", [])
