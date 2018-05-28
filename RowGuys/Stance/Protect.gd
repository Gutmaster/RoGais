extends "Stance.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Defend"
	stats.Endurance = 1
	stats.Willpower = 1
	apCost = 2