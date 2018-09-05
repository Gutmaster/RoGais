extends TextureButton


var mouseHover = false

onready var party = get_node("/root/Globals").party
onready var combatNode = get_node("/root/Globals").combatScene

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0
var apCost = 0

var buyPrice = 5
var sellPrice = 2

var userRows = []
var targetRows = []
var targetWholeRows = []
var targetFriendlyRows = []
var targetWholeFriendlyRows = []
var description = ""
onready var targetEnemyUnit = load("res://InfoBox/Assets/TargetableEnemyUnit.png")
onready var targetEnemyRow = load("res://InfoBox/Assets/TargetableEnemyRow.png")
onready var targetFriendlyUnit = load("res://InfoBox/Assets/TargetableFriendlyUnit.png")
onready var targetFriendlyRow = load("res://InfoBox/Assets/TargetableFriendlyRow.png")
onready var userRow = load("res://InfoBox/Assets/UsableRow.png")
onready var infoBox = get_node("ItemInfo/Box")

var delay = false
onready var parent = get_parent()


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
	
	for i in range(targetRows.size()):
		if(targetRows[i] == combatNode.ROW.front):
			find_node("RF").set_texture(targetEnemyUnit)
		if(targetRows[i] == combatNode.ROW.middle):
			find_node("RM").set_texture(targetEnemyUnit)
		if(targetRows[i] == combatNode.ROW.back):
			find_node("RB").set_texture(targetEnemyUnit)
	
	for i in range(targetWholeRows.size()):
		if(targetWholeRows[i] == combatNode.ROW.front):
			find_node("RF").set_texture(targetEnemyRow)
		if(targetWholeRows[i] == combatNode.ROW.middle):
			find_node("RM").set_texture(targetEnemyRow)
		if(targetWholeRows[i] == combatNode.ROW.back):
			find_node("RB").set_texture(targetEnemyRow)
	
	for i in range(targetFriendlyRows.size()):
		if(targetFriendlyRows[i] == combatNode.ROW.front):
			find_node("LF").set_texture(targetFriendlyUnit)
		if(targetFriendlyRows[i] == combatNode.ROW.middle):
			find_node("LM").set_texture(targetFriendlyUnit)
		if(targetFriendlyRows[i] == combatNode.ROW.back):
			find_node("LB").set_texture(targetFriendlyUnit)
	
	for i in range(targetWholeFriendlyRows.size()):
		if(targetWholeFriendlyRows[i] == combatNode.ROW.front):
			find_node("LF").set_texture(targetFriendlyRow)
		if(targetWholeFriendlyRows[i] == combatNode.ROW.middle):
			find_node("LM").set_texture(targetFriendlyRow)
		if(targetWholeFriendlyRows[i] == combatNode.ROW.back):
			find_node("LB").set_texture(targetFriendlyRow)


func Init():
	pass


func UseCheck():
	pass


func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.item
	temp.Init()
	
	return temp


func _on_Item_mouse_entered():
	var cmdTest = get_parent().get_parent().get_parent().find_node("InfoAnchor")
	if(cmdTest != null):
		infoBox.rect_global_position = cmdTest.rect_global_position
	else:
		infoBox.rect_global_position = get_parent().get_parent().find_node("InfoAnchor").rect_global_position
	mouseHover = true
	find_node("Box").visible = true


func _on_Item_mouse_exited():
	mouseHover = false
	find_node("Box").visible = false