extends PanelContainer

var unit
onready var partyScene = get_node("/root/Globals").party
onready var combatNode = get_node("/root/Globals").combatScene
onready var emptyPortrait = preload("res://Party/Assets/placeholder.png")


func _on_Portrait1_pressed():
	if(Globals.currentScene != Globals.combatScene):
		find_node("Portrait1").texture_normal = unit.portrait
		find_node("Portrait2").texture_normal = emptyPortrait
		find_node("Portrait3").texture_normal = emptyPortrait
	
		unit.defaultRow = unit.ROW.back


func _on_Portrait2_pressed():
	if(Globals.currentScene != Globals.combatScene):
		find_node("Portrait1").texture_normal = emptyPortrait
		find_node("Portrait2").texture_normal = unit.portrait
		find_node("Portrait3").texture_normal = emptyPortrait
	
		unit.defaultRow = unit.ROW.middle


func _on_Portrait3_pressed():
	if(Globals.currentScene != Globals.combatScene):
		find_node("Portrait1").texture_normal = emptyPortrait
		find_node("Portrait2").texture_normal = emptyPortrait
		find_node("Portrait3").texture_normal = unit.portrait
	
		unit.defaultRow = unit.ROW.front


"""func _on_TrinketSlot1_pressed():
	if(partyScene.itemRef && partyScene.itemRef.iType == trinket && !unit.trinket1):
		unit.trinket1 = partyScene.itemRef
		partyScene.itemRef = null
	elif(partyScene.itemRef == null && unit.trinket1):
		partyScene.itemRef = unit.trinket1
		unit.trinket1 = null
	elif(partyScene.itemRef && partyScene.itemRef.iType == trinket && unit.trinket1):
		var tempRef = partyScene.itemRef
		partyScene.itemRef = unit.trinket1
		unit.trinket1 = tempRef


func _on_TrinketSlot2_pressed():
	if(partyScene.itemRef && partyScene.itemRef.iType == trinket && !unit.trinket2):
		unit.trinket2 = partyScene.itemRef
		partyScene.itemRef = null
	elif(partyScene.itemRef == null && unit.trinket2):
		partyScene.itemRef = unit.trinket2
		unit.trinket2 = null
	elif(partyScene.itemRef && partyScene.itemRef.iType == trinket && unit.trinket2):
		var tempRef = partyScene.itemRef
		partyScene.itemRef = unit.trinket2
		unit.trinket2 = tempRef"""
