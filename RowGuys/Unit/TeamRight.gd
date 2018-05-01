extends "Team.gd"

onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	side = SIDE.right
	enemy = combatNode.get_node("TeamLeft")
	rpos["front"] = combatNode.get_node("Row/RF")
	rpos["middle"] = combatNode.get_node("Row/RM")
	rpos["back"] = combatNode.get_node("Row/RB")