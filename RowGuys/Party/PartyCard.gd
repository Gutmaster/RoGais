extends PanelContainer

var unit

onready var party = get_node("/root/Globals").party
onready var combatNode = get_node("/root/Globals").combatScene
onready var emptyPortrait = preload("res://Party/Assets/placeholder.png")


func _on_Portrait1_pressed():
	if(Globals.currentScene != Globals.combatScene && !party.itemHolder.item):
		find_node("Portrait1").texture_normal = unit.portrait
		find_node("Portrait2").texture_normal = emptyPortrait
		find_node("Portrait3").texture_normal = emptyPortrait
	
		unit.defaultRow = unit.ROW.back


func _on_Portrait2_pressed():
	if(Globals.currentScene != Globals.combatScene && !party.itemHolder.item):
		find_node("Portrait1").texture_normal = emptyPortrait
		find_node("Portrait2").texture_normal = unit.portrait
		find_node("Portrait3").texture_normal = emptyPortrait
	
		unit.defaultRow = unit.ROW.middle


func _on_Portrait3_pressed():
	if(Globals.currentScene != Globals.combatScene && !party.itemHolder.item):
		find_node("Portrait1").texture_normal = emptyPortrait
		find_node("Portrait2").texture_normal = emptyPortrait
		find_node("Portrait3").texture_normal = unit.portrait
	
		unit.defaultRow = unit.ROW.front



func _on_SkillTree_pressed():
	if(!(party.itemHolder.item)):
		Globals.ChangeScene(unit.skillTree)