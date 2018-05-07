extends "Stance.gd"

func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Defend"
	mod.Endurance = 1
	mod.Willpower = 1
	apCost = 2