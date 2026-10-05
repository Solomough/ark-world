extends Node3D

class_name Farm

var plots: Array = []
var farm_size: int = 4  # 4x4 grid

func _ready() -> void:
    generate_plots()

func generate_plots() -> void:
    for x in range(farm_size):
        for z in range(farm_size):
            var plot = FarmPlot.new()
            plot.position = Vector3(x * 2, 0, z * 2)
            plots.append(plot)
            add_child(plot)

func till_plot(plot_index: int) -> bool:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].till()
    return false

func plant_crop(plot_index: int, crop_type: String) -> bool:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].plant(crop_type)
    return false

func water_plot(plot_index: int) -> bool:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].water()
    return false

func harvest_plot(plot_index: int) -> Dictionary:
    if plot_index >= 0 and plot_index < plots.size():
        return plots[plot_index].harvest()
    return {}
