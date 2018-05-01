extends "res://Artifact/Artifact.gd"


func _ready():
	partyMod.Vitality = 1


func Upkeep(unit):
	unit.UpdateHP(1)