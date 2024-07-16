extends Node

#var brick = 30
#var ore = 35
#var wheat = 30
#var wood = 80
#var wool = 30
#var coins = 1000

var res = {"brick": 30, "ore": 35, "wheat": 30, "wood": 80, "wool": 30, "coins": 1000}

var housebuttonpressed = 0
var roadbuttonpressed = 0

var die_sum = 0

signal changed_resource

func resources():
	changed_resource.emit()
