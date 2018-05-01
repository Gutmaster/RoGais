extends CanvasLayer


var starting_food = 20
var food = 0
var gold = 0


onready var artifactContainer = find_node("ArtifactContainer")
onready var artifactContainer2 = find_node("ArtifactContainer2")


func _ready():
	UpdateFood(starting_food)
	artifactContainer.add_child(preload("res://Artifact/Pretty Rock.tscn").instance(), true)
	artifactContainer.get_child(0).Acquire()
	
	artifactContainer2.add_child(preload("res://Artifact/Pretty Rock.tscn").instance(), true)
	artifactContainer2.get_child(0).Acquire()


func _input(event):
	if(event.is_action_pressed("party_pause")):
		get_tree().paused = !(get_tree().paused)
		$Control.visible = !($Control.visible)
		$PanelContainer.visible = !($PanelContainer.visible)


func _process(delta):
	var round_value = round(food)
	find_node("FoodCount").text = str(round_value)
	find_node("FoodCount2").text = str(round_value)
	round_value = round(gold)
	find_node("GoldCount").text = str(round_value)
	find_node("GoldCount2").text = str(round_value)


func AddUnit(var unit):
	unit = unit.instance()
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