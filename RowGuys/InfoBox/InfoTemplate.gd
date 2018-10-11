extends TextureButton

var mouseHover = false

var descript = ["","",""]
var apCost = 0

var userRows = []
var targetRows = []
var targetWholeRows = []
var targetFriendlyRows = []
var targetWholeFriendlyRows = []

onready var combatNode = get_node("/root/Globals").combatScene
onready var actionMenu = combatNode.get_node("HUD/CommandWindow/Action")
onready var uList = combatNode.get_node("UnitList")

onready var targetEnemyUnit = load("res://InfoBox/Assets/TargetableEnemyUnit.png")
onready var targetEnemyRow = load("res://InfoBox/Assets/TargetableEnemyRow.png")
onready var targetFriendlyUnit = load("res://InfoBox/Assets/TargetableFriendlyUnit.png")
onready var targetFriendlyRow = load("res://InfoBox/Assets/TargetableFriendlyRow.png")
onready var userRow = load("res://InfoBox/Assets/UsableRow.png")
onready var moveLeft = load("res://InfoBox/Assets/MoveLeft.png")
onready var moveRight = load("res://InfoBox/Assets/MoveRight.png")
onready var doubleMoveLeft = load("res://InfoBox/Assets/DoubleMoveLeft.png")
onready var doubleMoveRight = load("res://InfoBox/Assets/DoubleMoveRight.png")

onready var infoBox = get_node("Info/Box")
onready var descriptBox = get_node("Description/Box")

var delay = false
onready var parent = get_parent()


func _ready():
	delay = true


func _process(delta):
	if(delay):
		SetInfo()
		delay = false
		
	MouseHover()


func SetInfo():
	if(infoBox != null):
		infoBox.find_node("AP").get_node("Amount").text = str(apCost)
	if(descriptBox != null):
		for i in range(descript.size()):
			descriptBox.get_node("Level" + str(i+1)).set_text(descript[i])
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


func HoverInfo():
	infoBox.parent.remove_child(infoBox)
	descriptBox.parent.remove_child(descriptBox)
	var anchor = get_tree().get_current_scene().find_node("Anchor")
	if(anchor != null):
		anchor.add_child(infoBox)
		anchor.add_child(descriptBox)
		descriptBox.visible = true
		infoBox.visible = true
		mouseHover = true


func NoHover():
	infoBox.get_parent().remove_child(infoBox)
	infoBox.parent.add_child(infoBox)
	descriptBox.get_parent().remove_child(descriptBox)
	descriptBox.parent.add_child(descriptBox)
	mouseHover = false
	infoBox.visible = false
	descriptBox.visible = false


func MouseHover():
	if(mouseHover):
		self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = Color(1,1,1,1)