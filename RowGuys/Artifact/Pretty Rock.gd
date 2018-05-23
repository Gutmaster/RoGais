extends "res://Artifact/Artifact.gd"


func _ready():
	partyMod.Vitality = 1
	description = "Grants regen 1 and increases vitality by 1 for the whole party"
	#party.find_node("Description").set_text(description)


func Upkeep(unit):
	unit.UpdateHP(1)