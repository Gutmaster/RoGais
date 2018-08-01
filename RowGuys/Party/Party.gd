extends CanvasLayer


enum ITYPE{
artifact,
trinket,
item}


var starting_food = 50
var starting_gold = 10
var food = 0
var gold = 0

onready var itemCatalogue = preload("res://Item/Item.tscn").instance()
onready var artifactCatalogue = preload("res://Artifact/Artifact.tscn").instance()
onready var trinketCatalogue = preload("res://Trinket/Trinket.tscn").instance()

onready var artifactSlot = find_node("ArtifactSlot")
onready var artifactContainer = find_node("ArtifactContainer")
onready var bottomRow = find_node("BottomRow")

onready var foodCount = find_node("FoodCount")
onready var foodCount2 = find_node("FoodCount2")
onready var goldCount = find_node("GoldCount")
onready var goldCount2 = find_node("GoldCount2")

var foodLabel
var goldLabel

onready var itemList = []
onready var itemHolder = $CanvasLayer/ItemHolder


func _ready():
	$HUD.visible = true
	$PartyMenu.visible = false
	
	UpdateFood(starting_food)
	UpdateGold(starting_gold)
	
	var startifact = artifactCatalogue.get_node("Pretty Rock").duplicate()
	
	AddArtifact(startifact)
	
	for i in range(1,8):
		itemList.push_back(find_node("Slot" + str(i)))
		
	AddItem(itemCatalogue.get_node("Red Goo"))
	AddItem(trinketCatalogue.get_node("Tribute Ring"))


func _input(event):
	if(event.is_action_pressed("party_pause")):
		PartyPause()


func _process(delta):
	foodCount.text = str(round(foodLabel))
	foodCount2.text = str(round(foodLabel))
	goldCount.text = str(round(goldLabel))
	goldCount2.text = str(round(goldLabel))


func AddUnit(var unit):
	unit = unit.instance()
	unit.Init()
	$Units.add_child(unit, true)
	unit.CharCardInit()
	unit.PartyCardInit()
	#unit.MiniPartyCardInit()
	unit.teamLeft = true
	var panelString = "Panel" + str($Units.get_child_count())
	find_node(panelString).add_child(unit.partyCard)
	find_node("Unit Cards").add_child(unit.quickStats)


func UpdateFood(dif):
	#$Tween.interpolate_property(self, "foodLabel", food, food + dif, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#$Tween.start()
	food += dif
	foodLabel = food


func UpdateGold(dif):
	$Tween.interpolate_property(self, "goldLabel", gold, gold + dif, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	gold += dif


func _on_PartyButton_pressed():
	PartyPause()


func _on_PartyButton2_pressed():
	PartyPause()


func PartyPause():
	if(Globals.currentScene == Globals.travelScene):
		Globals.travelScene.find_node("Player").destPos = null
		Globals.travelScene.find_node("Player").velocity = Vector2(0,0)
		Globals.travelScene.find_node("MoveMarker").visible = false
		
	if($HUD.visible):
		UpdatePartyCards()
	elif($PartyMenu.visible):
		if(itemHolder.item):
			itemHolder.itemCatcher.item = itemHolder.item
			itemHolder.remove_child(itemHolder.itemCatcher.item)
			itemHolder.item = null
			itemHolder.itemCatcher.add_child(itemHolder.itemCatcher.item)
			
			if(itemHolder.itemCatcher.item.iType == ITYPE.artifact):
				itemHolder.itemCatcher.item.Acquire()
				artifactContainer.add_child(itemHolder.itemCatcher.item.duplicate())
	
	get_tree().paused = !(get_tree().paused)
	$PartyMenu.visible = !($PartyMenu.visible)
	$HUD.visible = !($HUD.visible)


func UpdatePartyCards():
	var uList
	var count

	if(Globals.currentScene != Globals.combatScene):
		uList = $Units
		count = uList.get_child_count()
	else:
		uList = get_tree().get_nodes_in_group("Party")
		count = uList.size()

	for j in range(1,6):
		var panelString = "Panel" + str(j)
		if(find_node(panelString).get_child_count()):
			find_node(panelString).remove_child(find_node(panelString).get_child(0))
	
	for i in range(count):
		var unit
		
		if(Globals.currentScene != Globals.combatScene):
			unit = uList.get_child(i)
		else:
			unit = uList[i]
		
		unit.RefreshStats()
		
		var panelString = "Panel" + str(i+1)
	
		"""unit.partyCard.find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
		unit.partyCard.find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
		unit.partyCard.find_node("XPFrac").set_text("XP " + str(unit.xp) + "/" + str(unit.xpReq))
		unit.partyCard.find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
		unit.partyCard.find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)
		unit.partyCard.find_node("XPBar").set_value((float(unit.xp)/unit.xpReq) * 100)
		
		unit.partyCard.find_node("VitStat").set_text(" VIT " + str(unit.aStats.Vitality))
		unit.partyCard.find_node("StaStat").set_text(" STA " + str(unit.aStats.Stamina))
		unit.partyCard.find_node("StrStat").set_text(" STR " + str(unit.aStats.Strength))
		unit.partyCard.find_node("EndStat").set_text(" END " + str(unit.aStats.Endurance))
	
		unit.partyCard.find_node("WisStat").set_text(" WIS " + str(unit.aStats.Wisdom))
		unit.partyCard.find_node("WillStat").set_text("WILL " + str(unit.aStats.Willpower))
		unit.partyCard.find_node("SpeedStat").set_text(" SPD " + str(unit.aStats.Speed))
		"""
		find_node(panelString).add_child(unit.partyCard)



func AddArtifact(artifact):
	artifactSlot.add_child(artifact)
	artifactSlot.item = artifact
	bottomRow.find_node("Description").set_text(artifact.description)
	
	artifactContainer.add_child(artifact.duplicate())
	
	for i in range($Units.get_child_count()):
		$Units.get_child(i).RefreshStats()


func AddItem(item):
	item = item.Clone()
	var found = false
	
	for i in range(7):
		if(!found):
			if(itemList[i].item == null):
				found = true
				itemList[i].item = item
				itemList[i].add_child(item)
				print(itemList[i].get_name(), itemList[i].get_child_count())


func EnableSlots():
	artifactSlot.disabled = false
	
	for i in range(7):
		itemList[i].disabled = false
	
	for i in range($Units.get_child_count()):
		$Units.get_child(i).partyCard.find_node("TrinketSlot1").disabled = false
		$Units.get_child(i).partyCard.find_node("TrinketSlot2").disabled = false


func DisableSlots():
	artifactSlot.disabled = true
	
	for i in range(7):
		itemList[i].disabled = true
		
	for i in range($Units.get_child_count()):
		$Units.get_child(i).partyCard.find_node("TrinketSlot1").disabled = true
		$Units.get_child(i).partyCard.find_node("TrinketSlot2").disabled = true