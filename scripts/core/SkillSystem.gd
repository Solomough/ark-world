extends Node

class_name SkillSystem

var skills: Dictionary = {
    "agriculture": {"level": 1, "xp": 0},
    "building": {"level": 1, "xp": 0},
    "trading": {"level": 1, "xp": 0}
}

func gain_xp(skill_id: String, amount: int = 1) -> void:
    if skills.has(skill_id):
        skills[skill_id]["xp"] += amount
        if skills[skill_id]["xp"] >= 100:
            skills[skill_id]["level"] += 1
            skills[skill_id]["xp"] = 0

func get_skill_level(skill_id: String) -> int:
    if skills.has(skill_id):
        return skills[skill_id]["level"]
    return 1
