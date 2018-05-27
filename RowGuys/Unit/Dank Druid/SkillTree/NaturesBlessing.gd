extends "res://Unit/STNode.gd"


func _ready():
	maxLvl = 3


func Apply(level):
	var unit = get_parent().unit
	if(level == 1):
		unit.actionList.push_back(unit.get_node("ActionCatalogue/Nature's Blessing"))
	elif(level == 2):
		unit.get_node("ActionCatalogue/Nature's Blessing").level = 2