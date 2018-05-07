extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "Defend"
	mod.Endurance = 2
	mod.Willpower = 1
	apCost = 2