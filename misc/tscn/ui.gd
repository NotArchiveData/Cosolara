extends Control

@onready var wood_label = %wood_label
@onready var brick_label = %brick_label
@onready var ore_label = %ore_label
@onready var wheat_label = %wheat_label
@onready var wool_label = %wool_label
@onready var coin_label = %coin_label

func _ready():
	global_signal.changed_resource.connect(_on_changed_resource)
	
func _on_changed_resource():
	coin_label.text = str(global.res["coins"])
	brick_label.text = str(global.res["brick"])
	ore_label.text = str(global.res["ore"])
	wheat_label.text = str(global.res["wheat"])
	wood_label.text = str(global.res["wood"])
	wool_label.text = str(global.res["wool"])

