extends "res://Unit/STNode.gd"


func _ready():
	maxLvl = 1


func Apply(level):
	var unit = get_parent().unit
	if(level == 1):
		unit.frenzy = true