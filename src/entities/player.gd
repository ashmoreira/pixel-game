extends CharacterBody2D

@export var walk_speed: float = 120.0
@export var sprint_speed: float = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_zone: Area2D = $InteractionZone

func _physics_process(_delta: float) -> void:
	# if the dialogue box is present, player can't move
	if UiManager.is_message_visible():
		sprite.stop() # stop animation if dialogue is up
		if Input.is_action_pressed("interact"): # if E is pressed -> can move
			UiManager.hide_message() # close dialogue
			return
		return
		
	# keyboard inputs into direction
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#determine speed based on whether sprint is being used
	if direction != Vector2.ZERO:
		if Input.is_action_pressed("sprint"):
			velocity = direction * sprint_speed
		else:
			velocity = direction * walk_speed
	else: 
		velocity = Vector2.ZERO
	
	move_and_slide()
	#animation based on direction
	update_animation(direction)
	
	#interaction based on E key
	if Input.is_action_just_pressed("interact"):
		check_for_interactions()

func update_animation(direction: Vector2) -> void:
	# when still, stop animation
	if direction == Vector2.ZERO:
		sprite.stop()
		return
	
	# play directional animation loop
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			sprite.play("walk_right")
		else:
			sprite.play("walk_left")
	else:
		if direction.y > 0:
			sprite.play("walk_down")
		else:
			sprite.play("walk_up")
			
func check_for_interactions() -> void:
	#interactable areas that overlap the sensor
	var overlapping_areas = interaction_zone.get_overlapping_areas()
	
	for area in overlapping_areas:
		#checking for InteractableObject class
		if area is InteractableObject:
			area.execute_interaction()
			return
		#checking for DoorInteractable
		if area is DoorInteractable:
			area.execute_interaction()
			return
