extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Defend"
	mods.def = 0
	mods.spdef = 0
	apCost = 1