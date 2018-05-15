extends PanelContainer

onready var party = get_node("/root/Globals").party

var unit
onready var combatNode = get_node("/root/Globals").combatScene
onready var emptyPortrait = load("res://Unit/placeholder.png")


func _ready():
	set_process(true)

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


func _on_TrinketSlot1_pressed():
	#if(party.heldItem && !unit.trinket1):
		#pass#put heldItem in trinket1 slot
	#elif(!party.heldItem && unit.trinket1):
		#pass#remove trinket1, set heldItem to trinket1
	#elif(party.heldItem && unit.trinket1):
		#pass#swap trinkets
	pass


func _on_TrinketSlot2_pressed():
	pass # replace with function body
