extends "res://Overworld/Node/Node.gd"


func _ready():
	events.push_back(load("res://Event/Overworld/GooShoppeEvent.tscn"))