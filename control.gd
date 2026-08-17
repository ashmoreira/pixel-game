extends Control

const FIRST_SCENE := "res://src/scenes/schoolroom.tscn" # entry scene

func _on_start_pressed() -> void:
	GameManager.reset_progress()
	SceneFader.fade_and_change(FIRST_SCENE)

func _on_load_pressed() -> void:
	var scene_path := GameManager.load_game()
	if scene_path != "":
		SceneFader.fade_and_change(scene_path)
		
func _on_quit_pressed() -> void:
	get_tree().quit()
