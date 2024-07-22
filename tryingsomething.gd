extends Node3D

# Time between presses to consider it a double press
var double_press_time = 0.3

# Timer to track the time since the last press
var time_since_last_press = 0

# Flag to indicate if the key was pressed once
var single_press_detected = false

func _process(delta):
	# Update the timer
	if single_press_detected:
		time_since_last_press += delta

	# Check if the key is pressed
	if Input.is_action_just_pressed("up"):
		# If the key was pressed within the double_press_time, it's a double press
		if single_press_detected and time_since_last_press <= double_press_time:
			print("Double press detected")
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

