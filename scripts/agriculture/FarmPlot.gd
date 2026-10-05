extends Node3D

class_name FarmPlot

var state: String = "empty"  # empty, tilled, planted, growing, ready
var current_crop: String = ""
var growth_progress: float = 0.0
var water_level: float = 0.0

const CROP_GROWTH_TIME = {
    "maize": 6.0,
    "tomato": 4.0,
    "vegetable": 3.0,
}

const CROP_YIELD = {
    "maize": 3,
    "tomato": 5,
    "vegetable": 4,
}

func till() -> bool:
    if state == "empty":
        state = "tilled"
        return true
    return false

func plant(crop_type: String) -> bool:
    if state == "tilled" and CROP_GROWTH_TIME.has(crop_type):
        state = "planted"
        current_crop = crop_type
        growth_progress = 0.0
        water_level = 100.0
        return true
    return false

func water() -> bool:
    if state in ["planted", "growing"]:
        water_level = 100.0
        return true
    return false

func update_growth(delta: float) -> void:
    if state == "planted" and water_level > 0:
        var growth_rate = (water_level / 100.0) * (1.0 / CROP_GROWTH_TIME[current_crop])
        growth_progress += delta * growth_rate
        water_level -= delta * 5.0
        
        if growth_progress >= 1.0:
            state = "ready"
        elif state == "planted":
            state = "growing"

func harvest() -> Dictionary:
    if state == "ready":
        var yield_amount = CROP_YIELD.get(current_crop, 1)
        var result = {
            "crop": current_crop,
            "amount": yield_amount,
            "success": true,
        }
        reset()
        return result
    return {"success": false}

func reset() -> void:
    state = "empty"
    current_crop = ""
    growth_progress = 0.0
    water_level = 0.0

func get_state_info() -> Dictionary:
    return {
        "state": state,
        "crop": current_crop,
        "progress": growth_progress,
        "water": water_level,
    }
