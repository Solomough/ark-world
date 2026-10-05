extends Node

class_name NPCSchedule

var schedule: Array = []
var current_activity_index: int = 0
var time_in_activity: float = 0.0

func add_activity(time_start: float, time_end: float, location: Vector3, activity_type: String) -> void:
    schedule.append({
        "start": time_start,
        "end": time_end,
        "location": location,
        "activity": activity_type,
    })

func get_current_target(current_time: float) -> Vector3:
    for activity in schedule:
        if current_time >= activity["start"] and current_time < activity["end"]:
            return activity["location"]
    return schedule[0]["location"] if schedule.size() > 0 else Vector3.ZERO

func get_current_activity(current_time: float) -> String:
    for activity in schedule:
        if current_time >= activity["start"] and current_time < activity["end"]:
            return activity["activity"]
    return "idle"
