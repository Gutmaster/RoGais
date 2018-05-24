extends "Stance.gd"


func _ready():
	userRows = [combatNode.ROW.front, combatNode.ROW.middle, combatNode.ROW.back]
	animation = "Idle"