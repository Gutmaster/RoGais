extends "res://InfoBox/InfoTemplate.gd"

enum INTERRUPT{
none,
evade}


var animation

var level = 1

var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var bonus = {"Strength": 0, "Wisdom": 0, "fireCrit": false}


func _ready():
	pass


func _process(delta):
	pass


func SetInfo():
	infoBox.find_node("AP").get_node("Amount").text = str(apCost)
	descriptBox.get_node("Level1").set_text(descript[0])
	descriptBox.get_node("Level2").set_text(descript[1])
	descriptBox.get_node("Level3").set_text(descript[2])
	
	for i in range(userRows.size()):
		if(userRows[i] == combatNode.ROW.front):
			find_node("LF").get_node("UR").set_texture(userRow)
		if(userRows[i] == combatNode.ROW.middle):
			find_node("LM").get_node("UR").set_texture(userRow)
		if(userRows[i] == combatNode.ROW.back):
			find_node("LB").get_node("UR").set_texture(userRow)


func Interrupt(unit, target):
	return INTERRUPT.none


func PostAction(unit, target):
	pass


func UseCheck():
	if(combatNode.activeUnit.ap < apCost):
		return false
	
	for i in range(userRows.size()):
		if(combatNode.activeUnit.row == userRows[i]):
			return true
	
	return false


func _on_Stance_mouse_entered():
	HoverInfo()


func _on_Stance_mouse_exited():
	NoHover()