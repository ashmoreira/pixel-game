extends Area2D

@export var destination: Marker2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) -> void:
	if body is CharacterBody2D:
		if destination:
			body.global_position = destination.global_position
