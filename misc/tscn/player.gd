extends CharacterBody3D

@onready var head = $head
@onready var headcam = $head/headcam

var speed = 10.0
const WALK_SPEED = 10.0
const SPRINT_SPEED = 20.0
const JUMP_VELOCITY = 7
const SENSITIVITY = 0.01

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 90.0
const FOV_CHANGE = 0.5

# gravity and flight
var gravity = 20
const NOT_FLYING = 20
const FLYING = 0
const FLY_UP = 10
const FLY_DOWN = 10
var flying = false

# Double tap variables
var double_press_time = 0.3
var time_since_last_press = 0
var single_press_detected = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if single_press_detected:
		time_since_last_press += delta
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 1, input_dir.y)).normalized()

	apply_gravity(delta)
	misc_movement()
	apply_walking(delta, direction)
	
	#headbob
	t_bob += delta * velocity.length() * float(is_on_floor())
	headcam.transform.origin = headbob(t_bob)
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, speed * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	headcam.fov = lerp(headcam.fov, target_fov, delta * 8.0)

	move_and_slide()
	print("y velocity: ", velocity.y)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY / 2)
		headcam.rotate_x(-event.relative.y * SENSITIVITY / 2)
		headcam.rotation.x = clamp(headcam.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func misc_movement():
	# Handle sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
		
	# Handle jump & flight (upwards)
	if Input.is_action_pressed("up"):
		# pressed spacebar
		if gravity != 0:
			if Input.is_action_just_pressed("up"):
				if is_on_floor():
					# ONLY jump when on the ground
					velocity.y = JUMP_VELOCITY
				
				else:
					# start flying if spacebar pressed again
					gravity = FLYING
					flying = true
					print("starting to fly")
					
			# gravity is not zero AND youre holding spacebar
			else:
				if is_on_floor():
					# KEEP jumping if you hold spacebar
					velocity.y = JUMP_VELOCITY
		
		elif gravity == 0:
			# flying up
			velocity.y += FLY_UP

			# Check if the key is pressed
			if Input.is_action_just_pressed("up"):
				# If the key was pressed within the double_press_time, it's a double press
				if single_press_detected and time_since_last_press <= double_press_time:
					print("Double press detected")
					gravity = NOT_FLYING
					velocity.y -= NOT_FLYING
					flying = false
					# Reset the timer and flag
					time_since_last_press = 0
					single_press_detected = false
				else:
					# First press detected, start the timer
					single_press_detected = true
					time_since_last_press = 0

			# If the time exceeds the double press time, reset the flag
			if time_since_last_press > double_press_time:
				single_press_detected = false

	# Handle flight ( downwards )
	if Input.is_action_pressed("down"):
		if not is_on_floor() && flying:
			velocity.y -= FLY_DOWN

func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor() && not flying:
		velocity.y -= gravity * delta

	elif is_on_floor() && flying:
		gravity = NOT_FLYING
		flying = false
	
	elif not is_on_floor() && flying:
		gravity = FLYING
		velocity.y = 0

func apply_walking(delta, direction):
	# Walking
	if is_on_floor():
		if direction.x or direction.z:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
	
	else:
		# adding jump inertia
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# Stops sprint if you stop walking
	if abs(velocity.x) < 8.0 && abs(velocity.z) < 8.0:
		speed = WALK_SPEED

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
