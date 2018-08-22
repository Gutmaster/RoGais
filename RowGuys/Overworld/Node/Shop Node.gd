extends "res://Overworld/Node/Node.gd"


func _ready():
	find_node("Type").text = "SHoppy poppy"
	events.push_back(load("res://Event/Overworld/GooShoppeEvent.tscn"))