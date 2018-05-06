extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Defend"
	mod.def = 0
	mod.spdef = 0
	apCost = 1