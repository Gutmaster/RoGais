extends "res://Overworld/Node/Node.gd"


func _ready():
	$NodeInfo.find_node("Type").text = "A conspicuous monument."
	events.push_back(load("res://Event/Overworld/GooShoppeEvent.tscn"))