extends Node

var game_time: float = 7.0  # Start at 7 AM
var game_speed: float = 10.0  # 1 real second = 10 game minutes
var world_env: WorldEnvironment
var sun_light: DirectionalLight3D

func _ready() -> void:
    world_env = get_parent().get_node_or_null("WorldEnvironment")
    sun_light = get_parent().get_node_or_null("Sun")

func _process(delta: float) -> void:
    game_time += (delta * game_speed) / 60.0
    if game_time >= 24.0:
        game_time = 0.0
    update_lighting()

func update_lighting() -> void:
    if not sun_light:
        return
    
    # Sun rotation based on time of day
    var rotation_angle = (game_time / 24.0) * TAU
    sun_light.rotation.x = sin(rotation_angle) * 1.2
    sun_light.rotation.z = cos(rotation_angle) * 0.4
    
    # Adjust light intensity based on time
    var brightness = 0.3 + 0.7 * abs(sin(rotation_angle))
    sun_light.light_energy = brightness

func get_time_string() -> String:
    var hour = int(game_time)
    var minute = int((game_time - hour) * 60)
    return "%02d:%02d" % [hour, minute]

func get_time_of_day() -> String:
    if game_time >= 5.0 and game_time < 12.0:
        return "morning"
    elif game_time >= 12.0 and game_time < 17.0:
        return "afternoon"
    elif game_time >= 17.0 and game_time < 21.0:
        return "evening"
    else:
        return "night"
