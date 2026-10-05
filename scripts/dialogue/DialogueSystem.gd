extends Node3D

class_name DialogueSystem

var current_dialogue: Dictionary = {}
var is_active: bool = false
var player_ref: Node

func start_dialogue(npc: Node3D, topic: String = "greeting") -> Dictionary:
    if not npc.has_method("get_dialogue"):
        return {"text": "..."}
    
    var dialogue = npc.get_dialogue(topic)
    current_dialogue = dialogue
    is_active = true
    return dialogue

func handle_dialogue_choice(choice_index: int) -> String:
    if not current_dialogue.has("choices"):
        end_dialogue()
        return ""
    
    var choices = current_dialogue["choices"]
    if choice_index >= 0 and choice_index < choices.size():
        var choice = choices[choice_index]
        if choice.has("next_dialogue"):
            return choice["next_dialogue"]
        if choice.has("action"):
            execute_dialogue_action(choice["action"])
    
    end_dialogue()
    return ""

func execute_dialogue_action(action: Dictionary) -> void:
    match action.get("type", ""):
        "quest_start":
            if player_ref and player_ref.has_method("start_quest"):
                player_ref.start_quest(action["quest_id"])
        "quest_complete":
            if player_ref and player_ref.has_method("complete_objective"):
                player_ref.complete_objective(action["quest_id"], action["objective_id"])
        "give_reward":
            if player_ref and player_ref.economy:
                player_ref.economy.player_money += action.get("money", 0.0)

func end_dialogue() -> void:
    is_active = false
    current_dialogue = {}
