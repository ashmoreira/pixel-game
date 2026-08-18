extends Area2D
class_name DoorInteractable

@export_file("*.tscn") var normal_destination: String
@export_file("*.tscn") var scary_destination: String
@export var target_spawn_point: String = ""

@warning_ignore("unused_parameter")
func execute_interaction() -> void:
	var target_file: String = ""
		
	if GameManager.world_shifted and scary_destination != "":
		target_file = scary_destination
	elif normal_destination != "":
		target_file = normal_destination
		
	if target_file != "":
		GameManager.next_spawn_point = target_spawn_point 
		SceneFader.fade_and_change(target_file)
