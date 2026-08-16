extends CanvasLayer

@onready var note_box: PanelContainer = $NoteBox
@onready var note_label: Label = $NoteBox/Label
@onready var hint_box: PanelContainer = $HintBox
@onready var hint_label: Label = $HintBox/Label

func show_message(text:String, duration: float = 0.0) -> void:
	note_label.text = text
	note_box.show()
	if duration > 0.0:
		await get_tree().create_timer(duration).timeout
		print("auto hiding")
		note_box.hide()
	
func hide_message() -> void:
	note_box.hide()
	
func is_message_visible() -> bool:
	return note_box.visible
	
func show_hint(text: String, duration: float = 4.0) -> void:
	hint_label.text = text
	hint_box.show()
	await get_tree().create_timer(duration).timeout
	hint_box.hide()
