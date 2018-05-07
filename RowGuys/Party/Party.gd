extends CanvasLayer

var starting_food = 5
var food = 0
var gold = 0

onready var artifactCatalogue = preload("res://Artifact/Artifact.tscn").instance()

onready var artifactContainer = find_node("ArtifactContainer")
onready var artifactContainer2 = find_node("ArtifactContainer2")

onready var foodCount = find_node("FoodCount")
onready var foodCount2 = find_node("FoodCount2")
onready var goldCount = find_node("GoldCount")
onready var goldCount2 = find_node("GoldCount2")


func _ready():
	UpdateFood(starting_food)
	artifactContainer.add_child(artifactCatalogue.get_node("Pretty Rock").duplicate(), true)
	artifactContainer.get_child(0).Acquire()
	
	artifactContainer2.add_child(artifactCatalogue.get_node("Pretty Rock").duplicate(), true)


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
	var panelString = "Panel" + str($Units.get_child_count())
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
		
	get_tree().paused = !(get_tree().paused)
	$Control.visible = !($Control.visible)
	$PanelContainer.visible = !($PanelContainer.visible)
	
	