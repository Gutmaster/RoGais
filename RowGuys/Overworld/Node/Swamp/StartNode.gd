extends "res://Overworld/Node/Node.gd"


func _ready():
	$NodeInfo.find_node("Type").text = "Start Point"
	events.push_back(load("res://Event/Swamp/Start.tscn"))