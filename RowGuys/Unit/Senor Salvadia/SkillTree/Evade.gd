extends "res://Unit/STNode.gd"


func _ready():
	maxLvl = 3


func Apply(level):
	.Apply(level)
	unit.get_node("StanceCatalogue/Evade").level = level
	var unit = get_parent().unit
	if(level == 1):
		unit.stanceList.push_back(unit.get_node("StanceCatalogue/Evade"))