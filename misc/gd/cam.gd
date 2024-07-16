extends Camera3D

var move_speed = 30.0
var new_position

func _process(delta):

	var direction = Vector3.ZERO

	if Input.is_action_pressed("down"):
		direction -= transform.basis.y.normalized()
	if Input.is_action_pressed("up"):
		direction += transform.basis.y.normalized()
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x.normalized()
	if Input.is_action_pressed("right"):
		direction += transform.basis.x.normalized()
	
	new_position = global_transform.origin + direction * move_speed * delta
	global_transform.origin.x = new_position.x
	global_transform.origin.z = new_position.z
