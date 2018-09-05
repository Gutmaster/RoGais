extends "res://Item/Item.gd"


func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]


func Init():
	power = 5
	buyPrice = 5
	sellPrice = 2
	
	description = "Invigorating blue goo, tastes funny"


func Use(unit):
	unit.UpdateAP(power)
	unit.Poison(4)