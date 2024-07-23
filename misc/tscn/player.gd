extends CharacterBody3D

@onready var head = $head
@onready var headcam = $head/headcam

var speed
const WALK_SPEED = 10.0
const SPRINT_SPEED = 20.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 90.0
const FOV_CHANGE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8
const FLY_UP = 10
const FLY_DOWN = 10

var flying = false

# Time between presses to consider it a double press
var double_press_time = 0.7

# Timer to track the time since the last press
var time_since_last_press = 0

# Flag to indicate if the key was pressed once
var single_press_detected = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if single_press_detected:
		time_since_last_press += delta
	
	var direction = main_movement()

	# Add the gravity.
	if not is_on_floor() && not flying:
		velocity.y -= gravity * delta

	elif is_on_floor() && flying:
		gravity = 9.8
		flying = false
	
	if flying:
		velocity.y = 0
		
	speed = WALK_SPEED
	misc_movement(direction)
	
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
		
	#headbob
	t_bob += delta * velocity.length() * float(is_on_floor())
	headcam.transform.origin = headbob(t_bob)
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, speed * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	headcam.fov = lerp(headcam.fov, target_fov, delta * 8.0)

	move_and_slide()

# Head movement
func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		headcam.rotate_x(-event.relative.y * SENSITIVITY)
		headcam.rotation.x = clamp(headcam.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func misc_movement(distance):
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
				
				elif not is_on_floor():
					# start flying if spacebar pressed again
					gravity = 0
					velocity.y = 0
					flying = true
					print("does it keep coming here?")
				
			else:
				if is_on_floor():
					# KEEP jumping if you hold spacebar
					velocity.y = JUMP_VELOCITY
				
				elif gravity == 0:
					# flying up
					velocity.y = distance.y * FLY_UP
		
		elif gravity == 0:
			# flying up
			velocity.y = distance.y * FLY_UP

			# Check if the key is pressed
			if Input.is_action_just_pressed("up"):
				# If the key was pressed within the double_press_time, it's a double press
				if single_press_detected and time_since_last_press <= double_press_time:
					print("Double press detected")
					gravity = 9.8
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
		velocity.y -= FLY_DOWN

func main_movement():
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 1, input_dir.y)).normalized()
	
	return direction

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
