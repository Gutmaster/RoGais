extends "res://Unit/STNode.gd"


func _ready():
	maxLvl = 3


func Apply(level):
	if(level == 1):
		var unit = get_parent().unit
		unit.actionList.push_back(unit.get_node("ActionCatalogue/Ensnaring Vines"))