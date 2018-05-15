extends CanvasLayer

var starting_food = 5
var food = 0
var gold = 0

onready var itemCatalogue = preload("res://Item/Item.tscn").instance()
onready var artifactCatalogue = preload("res://Artifact/Artifact.tscn").instance()

onready var artifactContainer = find_node("ArtifactContainer")
onready var artifactContainer2 = find_node("ArtifactContainer2")

onready var foodCount = find_node("FoodCount")
onready var foodCount2 = find_node("FoodCount2")
onready var goldCount = find_node("GoldCount")
onready var goldCount2 = find_node("GoldCount2")

onready var itemList = []


func _ready():
	UpdateFood(starting_food)
	artifactContainer.add_child(artifactCatalogue.get_node("Pretty Rock").duplicate(), true)
	artifactContainer.get_child(0).Acquire()
	
	artifactContainer2.add_child(artifactCatalogue.get_node("Pretty Rock").duplicate(), true)
	
	itemList.push_back(itemCatalogue.get_node("Red Goo").duplicate())


func _input(event):
	if(event.is_action_pressed("party_pause")):
		PartyPause()


func _process(delta):
	var round_value = round(food)
	foodCount.text = str(round_value)
	foodCount2.text = str(round_value)
	round_value = round(gold)
	goldCount.text = str(round_value)
	goldCount2.text = str(round_value)


func AddUnit(var unit):
	unit = unit.instance()
	unit.Init()
	$Units.add_child(unit, true)
	unit.CharCardInit()
	unit.PartyCardInit()
	var panelString = "Panel" + str($Units.get_child_count() - 1)
	find_node(panelString).add_child(unit.partyCard)
	find_node("Unit Cards").add_child(unit.quickStats)


func UpdateFood(dif):
	$FTween.interpolate_property(self, "food", food, food + dif, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$FTween.start()


func UpdateGold(dif):
	$GTween.interpolate_property(self, "gold", gold, gold + dif, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$GTween.start()


func _on_PartyButton_pressed():
	PartyPause()


func _on_PartyButton2_pressed():
	PartyPause()
	

func PartyPause():
	if(Globals.currentScene == Globals.travelScene):
		Globals.travelScene.find_node("Player").destPos = null
		Globals.travelScene.find_node("Player").velocity = Vector2(0,0)
		Globals.travelScene.find_node("MoveMarker").visible = false
		
	if($PanelContainer.visible):
		UpdatePartyCards()
	
	get_tree().paused = !(get_tree().paused)
	$Control.visible = !($Control.visible)
	$PanelContainer.visible = !($PanelContainer.visible)
	
	
func UpdatePartyCards():
	var uList
	var count

	if(Globals.currentScene != Globals.combatScene):
		uList = $Units
		count = uList.get_child_count()
	else:
		uList = get_tree().get_nodes_in_group("Party")
		count = uList.size()

	for j in range(6):
		var panelString = "Panel" + str(j)
		find_node(panelString).remove_child(find_node(panelString).get_child(0))
	
	for i in range(count):
		var unit
		
		if(Globals.currentScene != Globals.combatScene):
			unit = uList.get_child(i)
		else:
			unit = uList[i]

		var panelString = "Panel" + str(i)
		
		#print(panelString)
		#print(str(unit.idName))
		
		#unit.PartyCardInit()
	
		unit.partyCard.find_node("HPFrac").set_text("HP " + str(unit.hp) + "/" + str(unit.aStats.Vitality))
		unit.partyCard.find_node("APFrac").set_text("AP " + str(unit.ap) + "/" + str(unit.aStats.Stamina))
		unit.partyCard.find_node("XPFrac").set_text("XP " + str(unit.xp) + "/" + str(unit.xpReq))
		unit.partyCard.find_node("HPBar").set_value((float(unit.hp)/unit.aStats.Vitality) * 100)
		unit.partyCard.find_node("APBar").set_value((float(unit.ap)/unit.aStats.Stamina) * 100)
	
		unit.partyCard.find_node("VitStat").set_text(" VIT " + str(unit.aStats.Vitality))
		unit.partyCard.find_node("StaStat").set_text(" STA " + str(unit.aStats.Stamina))
		unit.partyCard.find_node("StrStat").set_text(" STR " + str(unit.aStats.Strength))
		unit.partyCard.find_node("EndStat").set_text(" END " + str(unit.aStats.Endurance))
	
		unit.partyCard.find_node("WisStat").set_text(" WIS " + str(unit.aStats.Wisdom))
		unit.partyCard.find_node("WillStat").set_text("WILL " + str(unit.aStats.Willpower))
		unit.partyCard.find_node("SpeedStat").set_text(" SPD " + str(unit.aStats.Speed))
		
		find_node(panelString).add_child(unit.partyCard)