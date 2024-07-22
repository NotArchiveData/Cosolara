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

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		headcam.rotate_x(-event.relative.y * SENSITIVITY)
		headcam.rotation.x = clamp(headcam.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		
func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 1, input_dir.y)).normalized()
	# Add the gravity.
	if not is_on_floor() && not flying:
		velocity.y -= gravity * delta

	elif is_on_floor() && flying:
		gravity = 9.8
		flying = false

	# Handle jump & flight (upwards)
	if Input.is_action_pressed("up"):
		# pressed spacebar
		
		if Input.is_action_just_pressed("up"):
			if is_on_floor():
				# ONLY jump when on the ground
				velocity.y = JUMP_VELOCITY
			
			else:
				# start flying if spacebar pressed again
				gravity = 0
				velocity.y = 0
				flying = true
			
		else:
			if is_on_floor():
				# KEEP jumping if you hold spacebar
				velocity.y = JUMP_VELOCITY
			
			elif gravity == 0:
				# flying up
				velocity.y = direction.y * FLY_UP

	elif flying:
		velocity.y = 0
	
	# Handle flight ( downwards )
	
	if Input.is_action_pressed("down"):
		velocity.y -= FLY_DOWN
		print("going dowwwwwwwn")
		
		
	# Handle sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	
	else:
		speed = WALK_SPEED
	
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

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
