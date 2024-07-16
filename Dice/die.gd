extends RigidBody3D

@onready var raycasts = $Raycasts.get_children()
@onready var roll_die_button = %roll_die_button

var start_pos
var roll_strength = 30
var is_rolling = false

signal roll_finished(value)

func _ready():
	start_pos = global_position
	roll_die_button.pressed.connect(
		func(): 
			_roll()
	)

func _input(event):
	if event.is_action_pressed("ui_accept") && !is_rolling:
		_roll()

func _roll():
	#Reset state
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	#Random rotate on 3 axes
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2 * PI)) * transform.basis
	
	#Random throw
	var throw_vector = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	angular_velocity = throw_vector * roll_strength / 2
	apply_central_impulse(throw_vector * roll_strength)
	
	is_rolling = true


func _on_sleeping_state_changed():
	if sleeping:
		var landed_on_side = false
		for raycast in raycasts:
			if raycast.is_colliding():
				roll_finished.emit(raycast.opposite_side)
				
				landed_on_side = true
				is_rolling = false
				
		if !landed_on_side:
			_roll()

var die1 = 0
var die2 = 0

func _on_roll_finished(value):
	die1 = value
	is_diefinished()

func _on_die_2_roll_finished(value):
	die2 = value
	is_diefinished()

func is_diefinished():
	if die1 && die2:
		var die_value = die1 + die2
		global.die_sum = die_value
		global_signal.roll_sum()
		print("die output: ", die_value)
		
		die1 = 0
		die2 = 0
