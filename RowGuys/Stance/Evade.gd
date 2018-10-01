extends "Stance.gd"


func _ready():
	userRows = [combatNode.ROW.front]
	animation = "Defend"
	stats.Endurance = 1
	stats.Willpower = 1
	apCost = 2
	descript[0] = "1. Attempt to dodge the next incoming melee attack."
	descript[1] = "2. Remain in this stance after evading."
	descript[2] = "3. Evade chance is doubled."


func Interrupt(unit, target):
	var dodge = false
	var a = unit.aStats.Speed
	var b = target.aStats.Speed
	
	randomize()
	var c = randi()%(a+b) + 1
	
	if(c > b):
		dodge = true
		if(level < 3):
			randomize()
			dodge = randi()%2
	if(level < 2):
		unit.ChangeStance(unit.get_node("StanceCatalogue/Wait"))
	if(dodge):
		return INTERRUPT.evade
	else:
		return INTERRUPT.none