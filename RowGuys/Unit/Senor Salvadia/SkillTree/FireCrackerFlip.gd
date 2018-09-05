extends "res://Unit/STNode.gd"


func _ready():
	#$"Firecracker Flip".connect("pressed", self, "ActivateCheck")
	maxLvl = 3


func Apply(level):
	var unit = get_parent().unit
	if(level == 1):
		unit.actionList.push_back(unit.get_node("ActionCatalogue/Firecracker Flip"))