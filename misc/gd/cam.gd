extends Camera3D

@export var acceleration = 25.0
@export var move_speed = 50.0
@export var mouse_speed = 300.0

var velocity = Vector3.ZERO
var look_angles = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	
	look_angles.y = clamp(look_angles.y, PI / -2, PI / 2)
	set_rotation(Vector3(look_angles.y, look_angles.x, 0))

	var direction = update_direction()
	
	if direction.length_squared() > 0:
		velocity += direction * acceleration * delta
	
	if velocity.length() > move_speed:
		velocity = velocity.normalized() * move_speed
		
	translate(velocity * delta)

func _input(event):
	# Mouse Rotation
	if event is InputEventMouseMotion:
		look_angles -= event.relative / mouse_speed
		
func update_direction():
	# Getting the direction to move the camera from input
	
	var direction = Vector3()

	if Input.is_action_pressed("forward"):
		direction += Vector3.FORWARD
	if Input.is_action_pressed("backward"):
		direction += Vector3.BACK
	if Input.is_action_pressed("left"):
		direction += Vector3.LEFT
	if Input.is_action_pressed("right"):
		direction += Vector3.RIGHT
	if Input.is_action_pressed("up"):
		direction += Vector3.UP
	if Input.is_action_pressed("down"):
		direction += Vector3.DOWN
		
	if direction == Vector3.ZERO:
		velocity = Vector3.ZERO
	
	return direction.normalized()
	
