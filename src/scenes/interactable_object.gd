extends Area2D
class_name InteractableObject

@export_multiline var note_text: String = "There is nothing of interest here."
func execute_interaction() -> void:
	if UiManager.is_message_visible():
		UiManager.hide_message()
	else:
		UiManager.show_message(note_text, 6.0)
