extends PanelContainer

onready var party = get_node("/root/Globals").party

var unit
onready var combatNode = get_node("/root/Globals").combatScene
onready var emptyPortrait = load("res://Unit/placeholder.png")


func _ready():
	set_process(true)


func _process(delta):
	find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
	find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
	find_node("XPFrac").set_text("XP " + str(unit.xp) + "/" + str(unit.xpReq))
	find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
	find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)
	
	find_node("VitStat").set_text(" VIT " + str(unit.aStats.Vitality))
	find_node("StaStat").set_text(" STA " + str(unit.aStats.Stamina))
	find_node("StrStat").set_text(" STR " + str(unit.aStats.Strength))
	find_node("EndStat").set_text(" END " + str(unit.aStats.Endurance))
	
	find_node("WisStat").set_text(" WIS " + str(unit.aStats.Wisdom))
	find_node("WillStat").set_text("WILL " + str(unit.aStats.Willpower))
	find_node("SpeedStat").set_text(" SPD " + str(unit.aStats.Speed))

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
