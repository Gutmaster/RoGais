extends TextureButton

var mouseHover = false
onready var combatNode = get_node("/root/Globals").combatScene

var userRows = []

var animation

var level = 1

var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var bonus = {"Strength": 0, "Wisdom": 0, "fireCrit": false}

var apCost = 0

onready var userRow = load("res://InfoBox/Assets/UsableRow.png")
onready var uList = combatNode.get_node("UnitList")
onready var parent = get_parent()
onready var infoBox = get_node("StanceInfo/Box")
var delay = false


func _ready():
	delay = true


func _process(delta):
	if(delay):
		SetInfo()
		delay = false


func SetInfo():
	infoBox.find_node("AP").get_node("Amount").text = str(apCost)
	
	for i in range(userRows.size()):
		if(userRows[i] == combatNode.ROW.front):
			find_node("LF").get_node("UR").set_texture(userRow)
		if(userRows[i] == combatNode.ROW.middle):
			find_node("LM").get_node("UR").set_texture(userRow)
		if(userRows[i] == combatNode.ROW.back):
			find_node("LB").get_node("UR").set_texture(userRow)


func Interrupt(unit, target):
	pass


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
	var cmdTest = get_parent().get_parent().get_parent().find_node("InfoAnchor")
	if(cmdTest != null):
		infoBox.rect_global_position = cmdTest.rect_global_position
	else:
		infoBox.rect_global_position = get_parent().get_parent().find_node("InfoAnchor").rect_global_position
	mouseHover = true
	find_node("Box").visible = true


func _on_Stance_mouse_exited():
	mouseHover = false
	find_node("Box").visible = false