extends CharacterBody2D

const SPEED = 80.0
const ACCEL = 500.0  # Increased for snappier movement
const FRICTION = 600.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to keep it consistent
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
@export var next_scene_path: String

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		# Accelerate towards max speed
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCEL * delta)
		# Flip sprite based on direction
		sprite.flip_h = direction < 0
	else:
		# Apply friction
		var current_friction = FRICTION if is_on_floor() else FRICTION * 0.1
		velocity.x = move_toward(velocity.x, 0, current_friction * delta)

	move_and_slide()

# This function must be connected via the Signal tab from an Area2D node
func _on_detection_area_body_entered(body):
	if body == self: # If the player enters the area
		if next_scene_path != "":
			get_tree().change_scene_to_file(next_scene_path)
