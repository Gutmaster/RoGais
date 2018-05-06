extends "Stance.gd"

func _ready():
	animation = "Dance"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	mod.def = -1
	bonus.fireCrit = true
	apCost = 2