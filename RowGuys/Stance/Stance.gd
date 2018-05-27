extends Control


onready var combatNode = get_node("/root/Globals").combatScene

var userRows = []

var animation

var mod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var bonus = {"Strength": 0, "Wisdom": 0, "fireCrit": false}

var apCost = 0


onready var uList = combatNode.get_node("UnitList")


func _ready():
	set_process(false)


func UseCheck():
	if(combatNode.activeUnit.ap < apCost):
		return false
		
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false