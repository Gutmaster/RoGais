extends "res://Trinket/Trinket.gd"



func _ready():
	stats.Vitality += 1
	stats.Stamina += 1
	stats.Strength += 1
	stats.Endurance += 1
	stats.Wisdom += 1
	stats.Willpower += 1
	stats.Speed += 1


func Upkeep(unit):
	unit.UpdateHP(-1)