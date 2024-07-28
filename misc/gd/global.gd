extends Node

#var res = {
	#"brick": 250, 
	#"ore": 0, 
	#"wheat": 110, 
	#"wood": 180, 
	#"wool": 105, 
	#"coins": 150
#}

var res = {
	"brick": 1000, 
	"ore": 1000, 
	"wheat": 1000, 
	"wood": 1000, 
	"wool": 1000, 
	"coins": 1000
}

var housebuttonpressed = 0
var roadbuttonpressed = 0
var die_sum = 0

func buy_road():
	res["coins"] -= 5
	res["brick"] -= 20
	global_signal.resources()

func buy_house():
	res["coins"] -= 40
	res["brick"] -= 100
	res["wood"] -= 70
	global_signal.resources()

func upgrade_house():
	res["coins"] -= 80
	res["brick"] -= 100
	res["wood"] -= 100
	res["wheat"] -= 100
	res["wool"] -= 100
	global_signal.resources()
