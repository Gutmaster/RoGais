extends "Stance.gd"


func _ready():
	animation = "Retaliate"
	userRows = [combatNode.ROW.front]
	apCost = 4


func PostAction(unit, target):
	unit.find_node("Melee").Init(unit, target, true)
	if(level >= 3):
		unit.QueueChangeStance(self)
	else:
		unit.QueueChangeStance(get_parent().get_node("Wait"))