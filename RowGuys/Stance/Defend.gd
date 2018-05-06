extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "Defend"
	mod.def = 2
	mod.spdef = 1
	apCost = 2