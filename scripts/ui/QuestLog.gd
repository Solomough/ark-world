extends CanvasLayer

signal start_requested
signal continue_requested
signal new_game_requested

func _ready() -> void:
    build_menu()

func build_menu() -> void:
    var root = Panel.new()
    root.name = "MainMenuPanel"
    root.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    root.anchor_left = 0.0
    root.anchor_top = 0.0
    root.anchor_right = 1.0
    root.anchor_bottom = 1.0
    root.offset_left = 0
    root.offset_top = 0
    root.offset_right = 0
    root.offset_bottom = 0
    add_child(root)

    var bg = ColorRect.new()
    bg.color = Color(0.05, 0.08, 0.12, 0.92)
    bg.anchor_left = 0.0
    bg.anchor_top = 0.0
    bg.anchor_right = 1.0
    bg.anchor_bottom = 1.0
    root.add_child(bg)

    var center = VBoxContainer.new()
    center.alignment = BoxContainer.ALIGNMENT_CENTER
    center.anchor_left = 0.5
    center.anchor_top = 0.5
    center.anchor_right = 0.5
    center.anchor_bottom = 0.5
    center.offset_left = -160
    center.offset_top = -120
    center.offset_right = 160
    center.offset_bottom = 120
    root.add_child(center)

    var title = Label.new()
    title.text = "ARK WORLD"
    title.add_theme_font_size_override("font_size", 48)
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    center.add_child(title)

    var subtitle = Label.new()
    subtitle.text = "Build. Learn. Become."
    subtitle.add_theme_font_size_override("font_size", 18)
    subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    center.add_child(subtitle)

    var spacer = Control.new()
    spacer.custom_minimum_size = Vector2(0, 24)
    center.add_child(spacer)

    var start_button = Button.new()
    start_button.text = "Start Game"
    start_button.custom_minimum_size = Vector2(260, 48)
    start_button.pressed.connect(func() -> void: emit_signal("start_requested"))
    center.add_child(start_button)

    var continue_button = Button.new()
    continue_button.text = "Continue"
    continue_button.custom_minimum_size = Vector2(260, 48)
    continue_button.pressed.connect(func() -> void: emit_signal("continue_requested"))
    center.add_child(continue_button)

    var new_game_button = Button.new()
    new_game_button.text = "New Game"
    new_game_button.custom_minimum_size = Vector2(260, 48)
    new_game_button.pressed.connect(func() -> void: emit_signal("new_game_requested"))
    center.add_child(new_game_button)

    var footer = Label.new()
    footer.text = "A living settlement prototype"
    footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    center.add_child(footer)
