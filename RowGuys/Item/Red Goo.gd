extends "res://Item/Item.gd"


func _ready():
	pass


func Init():
	power = 5
	buyPrice = 5
	sellPrice = 2
	
	description = "Healing red goo"


func Use(unit):
	unit.UpdateHP(power)