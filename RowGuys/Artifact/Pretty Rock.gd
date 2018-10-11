extends "res://Artifact/Artifact.gd"


func _ready():
	stats.Vitality = 1
	descript[0] = "Pretty Rock: Grants regen 1 and increases vitality by 1 for the whole party"
	buyPrice = 5
	sellPrice = 2
	bpCost = 3


func Upkeep(unit):
	unit.UpdateHP(1)