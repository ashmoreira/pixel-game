extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

# for smoother transition -> fade between scenes
func _ready() -> void:
	# start transparent
	color_rect.modulate.a = 0.0
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # let mouse clicks pass through when transparent

# actual fade out
func fade_and_change(target_path: String) -> void:
	color_rect.MOUSE_FILTER_STOP # block mouse during fade
	
	#fade to black
	var tween_out = create_tween()
	tween_out.tween_property(color_rect, "modulate:a", 1.0, 0.6)
	await tween_out.finished
	
	#change scene 
	get_tree().change_scene_to_file(target_path)
	await get_tree().process_frame
	
	#fade from black
	var tween_in = create_tween()
	tween_in.tween_property(color_rect, "modulate:a", 0.0, 0.6)
	await tween_in.finished
	
	color_rect.MOUSE_FILTER_IGNORE
