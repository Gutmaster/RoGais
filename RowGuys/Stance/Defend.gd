extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "Defend"
	mods.def = 2
	mods.spdef = 1
	apCost = 2