extends Node2D
class_name RoomBase

func _ready() -> void:
	print("RoomBase _ready running, next_spawn_point is: ", GameManager.next_spawn_point)
	if GameManager.next_spawn_point != "":
		var spawn_marker = get_node_or_null(GameManager.next_spawn_point)
		print("spawn_marker found: ", spawn_marker)
		if spawn_marker:
			var player = get_tree().get_first_node_in_group("player")
			print("All nodes in player group: ", get_tree().get_nodes_in_group("player"))
			player.apply_spawn(spawn_marker)
		GameManager.next_spawn_point = ""
