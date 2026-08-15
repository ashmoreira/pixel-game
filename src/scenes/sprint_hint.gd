extends Area2D

@export var hint_message: String = "Press [Shift] to sprint down long stretches if needed."

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		UiManager.show_hint(hint_message)
		queue_free()

	
