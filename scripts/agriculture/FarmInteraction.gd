extends Node3D

class_name FarmInteraction

@export var farm_name: String = "My Farm"
@export var plot_count: int = 4
@export var farm_position: Vector3 = Vector3.ZERO

var plots: Array = []
var player_inventory: Node

func _ready() -> void:
    add_to_group("farm")
    global_position = farm_position
    setup_plots()

func setup_plots() -> void:
    for i in range(plot_count):
        var plot = FarmPlot.new()
        plots.append(plot)
        add_child(plot)

func set_player_inventory(inv: Node) -> void:
    player_inventory = inv

func till_plot(plot_index: int) -> bool:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].till()
    return false

func plant_crop(plot_index: int, crop_type: String) -> bool:
    if player_inventory and player_inventory.has_method("remove_item"):
        var seed_type = "seed_%s" % crop_type
        if not player_inventory.remove_item(seed_type, 1):
            return false
    
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].plant(crop_type)
    return false

func water_plot(plot_index: int) -> bool:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].water()
    return false

func harvest_plot(plot_index: int) -> Dictionary:
    if plot_index >= 0 and plot_index < plots.size():
        var harvest_result = plots[plot_index].harvest()
        if harvest_result.get("success", false) and player_inventory:
            var crop = harvest_result.get("crop", "vegetable")
            var amount = harvest_result.get("amount", 1)
            player_inventory.add_item(crop, amount)
        return harvest_result
    return {}

func get_plots_state() -> Array:
    var state: Array = []
    for plot in plots:
        state.append(plot.get_state_info())
    return state

func get_farm_greeting() -> String:
    return "This is %s. You can till, plant, water, and harvest crops here." % farm_name
