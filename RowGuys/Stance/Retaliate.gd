extends "Stance.gd"


func _ready():
	animation = "Retaliate"
	userRows = [combatNode.ROW.front]
	apCost = 4
	descript[0] = "1. Strike back at any unit that deals melee damage to this unit."
	descript[1] = "2. Remain in this stance after retaliating."


func PostAction(unit, target):
	unit.find_node("Melee").Init(unit, target, true)
	if(level >= 3):
		unit.QueueChangeStance(self)
	else:
		unit.QueueChangeStance(get_parent().get_node("Wait"))