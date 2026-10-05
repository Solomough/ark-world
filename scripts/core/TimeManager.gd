extends Node

class_name TimeManager

var start_time: float = 7.0
var game_speed: float = 10.0
var current_time: float = 7.0

func _ready() -> void:
    current_time = start_time

func _process(delta: float) -> void:
    current_time += delta * (game_speed / 60.0)
    if current_time >= 24.0:
        current_time -= 24.0
    update_daylight()

func update_daylight() -> void:
    var sun = get_parent().get_node_or_null("Sun")
    if sun == null:
        return

    var t = current_time / 24.0
    var angle = t * TAU
    sun.rotation.x = sin(angle) * 1.2
    sun.rotation.z = cos(angle) * 0.4
    var brightness = 0.25 + 0.75 * max(0.0, sin(angle))
    sun.light_energy = brightness

func get_time_string() -> String:
    var hour = int(floor(current_time))
    var minute = int((current_time - hour) * 60.0)
    return "%02d:%02d" % [hour, minute]
