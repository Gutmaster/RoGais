extends "Stance.gd"


func _ready():
	animation = "Dance"
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	stats.Endurance = -1
	bonus.fireCrit = true
	apCost = 2
	descript[0] = "1. A stance that leaves the user vulnerable, but guarantees the next fire move used will be a critical hit."