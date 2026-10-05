extends Node

class_name SkillSystem

var skills: Dictionary = {}

const SKILLS = [
    "agriculture",
    "construction",
    "commerce",
    "technology",
    "communication",
    "leadership",
    "craftsmanship",
    "driving",
    "management",
    "problem_solving",
]

func _ready() -> void:
    for skill in SKILLS:
        skills[skill] = {
            "level": 1,
            "xp": 0,
            "xp_to_next": 100,
        }

func add_xp(skill: String, amount: int) -> void:
    if not skills.has(skill):
        return
    
    skills[skill]["xp"] += amount
    
    while skills[skill]["xp"] >= skills[skill]["xp_to_next"]:
        level_up_skill(skill)

func level_up_skill(skill: String) -> void:
    if not skills.has(skill):
        return
    
    skills[skill]["level"] += 1
    skills[skill]["xp"] = 0
    skills[skill]["xp_to_next"] = int(skills[skill]["xp_to_next"] * 1.1)
    print("%s is now level %d" % [skill, skills[skill]["level"]])

func get_skill_level(skill: String) -> int:
    return skills.get(skill, {}).get("level", 1)

func get_skill_xp(skill: String) -> int:
    return skills.get(skill, {}).get("xp", 0)

func get_all_skills() -> Dictionary:
    return skills.duplicate(true)
