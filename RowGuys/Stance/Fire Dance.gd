extends "Stance.gd"

func _ready():
	animation = "Dance"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	mods.def = -1
	bonus.fireCrit = true
	apCost = 2