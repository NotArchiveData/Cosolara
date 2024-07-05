extends Node

@onready var label = $CanvasLayer/Label

var die1_done = false
var die2_done = false
var die1 = 0
var die2 = 0

func _on_die_roll_finished(value):
	die1_done = true
	die1 = value
	check()

func _on_die_2_roll_finished(value):
	die2_done = true
	die2 = value
	check()

func check():
	if die1_done && die2_done:
		var die_value = die1 + die2
		label.text = str(die_value)
		
		die1 = 0
		die2 = 0
		die1_done = false
		die2_done = false
