extends Node

class_name CharacterCreator

var name_value: String = "Ayo"
var gender_presentation: String = "male"
var skin_tone: String = "medium"
var hair_style: String = "short"
var hair_color: String = "black"
var clothing_style: String = "workwear"
var background: String = "farming"

func generate_summary() -> Dictionary:
    return {
        "name": name_value,
        "gender_presentation": gender_presentation,
        "skin_tone": skin_tone,
        "hair_style": hair_style,
        "hair_color": hair_color,
        "clothing_style": clothing_style,
        "background": background,
    }

func apply_defaults() -> void:
    name_value = "Ayo"
    gender_presentation = "male"
    skin_tone = "medium"
    hair_style = "short"
    hair_color = "black"
    clothing_style = "workwear"
    background = "farming"
