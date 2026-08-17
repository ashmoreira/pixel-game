extends RoomBase

func _ready() -> void:
	super ._ready() # runs spawn logic
	#give time fore nodes to load
	await get_tree().create_timer(0.1).timeout
	start_prologue()

func start_prologue() -> void:
	UiManager.show_message("...Ugh, my head. Did I fall asleep studying?\nLooks like everyone else left already. I should head back to my dorm.")
