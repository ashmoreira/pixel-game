extends Control

const FIRST_SCENE := "res://scenes/schroolroom.tscn" # entry scene

func _on_start_pressed() -> void:
	SceneFader.fade_and_change(FIRST_SCENE)

func _on_quit_pressed() -> void:
	get_tree().quit()
