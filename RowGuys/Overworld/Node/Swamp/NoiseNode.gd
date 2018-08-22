extends "res://Overworld/Node/Node.gd"


func _ready():
	$NodeInfo.find_node("Type").text = "A great clamor."
	events.push_back(load("res://Event/Enemy/GoombaEvent.tscn"))