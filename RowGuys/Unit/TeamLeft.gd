extends "Team.gd"

onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	side = SIDE.left
	enemy = combatNode.get_node("TeamRight")
	rpos["front"] = combatNode.get_node("Row/LF") 
	rpos["middle"] = combatNode.get_node("Row/LM") 
	rpos["back"] = combatNode.get_node("Row/LB") 