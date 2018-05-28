extends "Stance.gd"


func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "Defend"
	stats.Endurance = 2
	stats.Willpower = 1
	apCost = 2