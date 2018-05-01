extends Control

onready var combatNode = get_node("/root/Globals").combatScene

var userRows = []

var animation

var mods = {"Endurance": 0, "Willpower": 0}
var bonus = {"Strength": 0, "Wisdom": 0, "fireCrit": false}
var apCost = 0


onready var uList = combatNode.get_node("UnitList")



func _ready():
	set_process(false)
	pass


func UseCheck():
	if(combatNode.activeUnit.stats.ap < apCost):
		return false
		
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false