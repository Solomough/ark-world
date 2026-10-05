extends Node

class_name SaveManager

const SAVE_PATH := "user://ark_world_save.json"
var save_version := 1

func save_game(data: Dictionary) -> Error:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file == null:
        return FileAccess.get_open_error()

    var payload := data.duplicate()
    payload["save_version"] = save_version
    file.store_string(JSON.stringify(payload, "", true))
    file.close()
    return OK

func load_game() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        return {}

    var json := JSON.new()
    var parse_error := json.parse(file.get_as_text())
    file.close()

    if parse_error != OK:
        return {}

    var payload = json.data
    if payload is Dictionary:
        return payload as Dictionary
    return {}

func delete_save() -> void:
    if FileAccess.file_exists(SAVE_PATH):
        DirAccess.remove_absolute(SAVE_PATH)
