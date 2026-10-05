extends CanvasLayer

class_name TradeUI

var player_ref: Node
var stall_ref: MarketStall
var is_open: bool = false

func _ready() -> void:
    visible = false

func open_trade(stall: MarketStall, player: Node) -> void:
    stall_ref = stall
    player_ref = player
    is_open = true
    visible = true
    
    var dialog = Label.new()
    dialog.text = stall.get_vendor_greeting()
    dialog.custom_minimum_size = Vector2(400, 100)
    add_child(dialog)
    
    await get_tree().create_timer(2.0).timeout
    visible = false
    is_open = false

func close_trade() -> void:
    is_open = false
    visible = false
    for child in get_children():
        child.queue_free()
