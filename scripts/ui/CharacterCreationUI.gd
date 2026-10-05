extends CanvasLayer

class_name CharacterCreationUI

var character_data: Dictionary = {
    "name": "Ayo",
    "gender": "male",
    "skin_tone": "medium",
    "hair_style": "short",
    "background": "farming"
}

var on_complete: Callable

func _ready() -> void:
    build_creation_screen()

func build_creation_screen() -> void:
    var root = Panel.new()
    root.name = "CreationPanel"
    root.anchor_left = 0.0
    root.anchor_top = 0.0
    root.anchor_right = 1.0
    root.anchor_bottom = 1.0
    add_child(root)

    var bg = ColorRect.new()
    bg.color = Color(0.05, 0.08, 0.12, 0.95)
    bg.anchor_left = 0.0
    bg.anchor_top = 0.0
    bg.anchor_right = 1.0
    bg.anchor_bottom = 1.0
    root.add_child(bg)

    var center = VBoxContainer.new()
    center.anchor_left = 0.5
    center.anchor_top = 0.5
    center.anchor_right = 0.5
    center.anchor_bottom = 0.5
    center.offset_left = -200
    center.offset_top = -180
    center.offset_right = 200
    center.offset_bottom = 180
    root.add_child(center)

    var title = Label.new()
    title.text = "CREATE YOUR CHARACTER"
    title.add_theme_font_size_override("font_size", 32)
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    center.add_child(title)

    var subtitle = Label.new()
    subtitle.text = "Welcome to Ark World. Who will you become?"
    subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    center.add_child(subtitle)

    var spacer = Control.new()
    spacer.custom_minimum_size = Vector2(0, 16)
    center.add_child(spacer)

    # Name input
    var name_label = Label.new()
    name_label.text = "Your Name:"
    center.add_child(name_label)
    
    var name_input = LineEdit.new()
    name_input.text = character_data["name"]
    name_input.text_changed.connect(func(text: String) -> void: character_data["name"] = text)
    center.add_child(name_input)

    # Gender selection
    var gender_label = Label.new()
    gender_label.text = "Gender Presentation:"
    center.add_child(gender_label)
    
    var gender_option = OptionButton.new()
    gender_option.add_item("Male")
    gender_option.add_item("Female")
    gender_option.add_item("Non-binary")
    gender_option.item_selected.connect(func(idx: int) -> void: character_data["gender"] = ["male", "female", "non_binary"][idx])
    center.add_child(gender_option)

    # Background selection
    var bg_label = Label.new()
    bg_label.text = "Background:"
    center.add_child(bg_label)
    
    var bg_option = OptionButton.new()
    bg_option.add_item("Farmer")
    bg_option.add_item("Builder")
    bg_option.add_item("Merchant")
    bg_option.item_selected.connect(func(idx: int) -> void: character_data["background"] = ["farming", "building", "merchant"][idx])
    center.add_child(bg_option)

    spacer = Control.new()
    spacer.custom_minimum_size = Vector2(0, 16)
    center.add_child(spacer)

    # Create button
    var create_btn = Button.new()
    create_btn.text = "Enter Ark World"
    create_btn.custom_minimum_size = Vector2(200, 48)
    create_btn.pressed.connect(_on_create_pressed)
    center.add_child(create_btn)

func _on_create_pressed() -> void:
    visible = false
    if on_complete.is_valid():
        on_complete.call(character_data)

func set_on_complete(callback: Callable) -> void:
    on_complete = callback
