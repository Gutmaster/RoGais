extends "res://Unit/STNode.gd"


func _ready():
	maxLvl = 1


func Apply(level):
	.Apply(level)
	var unit = get_parent().unit
	if(level == 1):
		unit.actionList.push_back(unit.get_node("ActionCatalogue/Lasso"))