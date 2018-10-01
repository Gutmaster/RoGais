extends "res://Item/Item.gd"


func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]


func Init():
	power = 5
	buyPrice = 5
	sellPrice = 2
	
	descript[0] = "Healing red goo"


func Use(unit):
	unit.UpdateHP(power)