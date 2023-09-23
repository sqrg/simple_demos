extends CharacterBody2D


@export var base_speed = 300.0
@export var jump_velocity_max = -400.0
@export var jump_velocity_min = -200.0
@export var run_multiplier = 1.3

var jumps_max = 2
var jumps_count = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and jumps_count != 0:
		jumps_count = 0
		
	if jumps_count < jumps_max:
		if Input.is_action_just_pressed("jump") and jumps_count < jumps_max:
			velocity.y = jump_velocity_min
			jumps_count += 1
	
	var speed = base_speed
	
	if Input.is_action_pressed("run") and is_on_floor():
		speed *= run_multiplier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
