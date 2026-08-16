extends Node


# tracking progress
var has_notebook: bool = false
var world_shifted: bool = false

const SAVE_PATH := "user://savegame.json"

func reset_progress() -> void:
	has_notebook = false
	world_shifted = false

func save_game(current_scene_path: String) -> void:
	var save_data := {
		"has_notebook": has_notebook,
		"world_shifted": world_shifted,
		"scene_path": current_scene_path
	}
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game() -> String:
	if not FileAccess.file_exists(SAVE_PATH):
		return ""
		
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_text := file.get_as_text()
	file.close()
	
	var save_data = JSON.parse_string(json_text)
	if save_data == null:
		return ""
	
	has_notebook = save_data.get("has_notebook", false)
	world_shifted = save_data.get("world_shited", false)
	return save_data.get("scene_path","")

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
