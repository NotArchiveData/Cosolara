extends Control

@onready var wood_label = %wood_label
@onready var brick_label = %brick_label
@onready var ore_label = %ore_label
@onready var wheat_label = %wheat_label
@onready var sheep_label = %sheep_label
@onready var coin_label = %coin_label

func _ready():
	global.changed_resource.connect(_on_changed_resource)
	
func _on_changed_resource():
	coin_label.text = str(global.res["coins"])

