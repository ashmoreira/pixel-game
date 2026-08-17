extends Area2D

@export_file("*.tscn") var normal_destination: String
@export_file("*.tscn") var scary_destination: String
@export var target_spawn_point: String = ""

# block doors once youve walked through
@export var block: bool = false
@export var block_message: String = "I really should be getting back to my dorm. It is getting late..."

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	
	#block logic: if block and world hasnt shifted
	if block and not GameManager.world_shifted:
		UiManager.show_message(block_message)
		return 
	
	var target_file: String = ""
		
	if GameManager.world_shifted and scary_destination != "":
		target_file = scary_destination
	elif normal_destination != "":
		target_file = normal_destination
		
	if target_file != "":
		print("setting next spawn", target_spawn_point)
		GameManager.next_spawn_point = target_spawn_point
		SceneFader.fade_and_change(target_file)
