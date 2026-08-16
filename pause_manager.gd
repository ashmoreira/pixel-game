extends CanvasLayer

@onready var dim_overlay: ColorRect = $DimOverlay
@onready var pause_panel: Control = $PausePanel
@onready var volume_slider: HSlider = $PausePanel/CenterContainer/VBoxContainer/VolumeSlider
@onready var fullscreen_toggle: CheckButton = $PausePanel/CenterContainer/VBoxContainer/FullscreenToggle

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS # when pause is true game still responds here
	dim_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	dim_overlay.hide() # start hidden
	pause_panel.hide()
	
	var bus_index := AudioServer.get_bus_index("Master") # returns volume in decibels
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index)) #convert to linear values
	fullscreen_toggle.button_pressed = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN) # check if fullscreen and match to toggle
	
	#connect to signals
	volume_slider.value_changed.connect(_on_volume_changed)
	fullscreen_toggle.toggled.connect(_on_fullscreen_toggled)
	
func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused #toggles the pause back and forth
	dim_overlay.visible = get_tree().paused #dim and panel match the back and forth
	pause_panel.visible = get_tree().paused
	
func _on_resume_pressed() -> void:
	toggle_pause() #when resume is clicked calls func

func _on_restart_pressed() -> void:
	get_tree().paused = false # unpause first
	dim_overlay.hide() 
	pause_panel.hide()
	GameManager.reset_progress()
	SceneFader.fade_and_change("res://scenes/main_menu.tscn")
	
func _on_volume_changed(value:float) -> void: # when slider moves value is new position
	var bus_index := AudioServer.get_bus_index("Master") 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) # converts back to decibels and applies

func _on_fullscreen_toggled(pressed: bool) -> void:
	if pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
