extends Node


var enemyParty

var defaultCursor = load("res://Mouse.png")

var packedParty = load("res://Party/Party.tscn")
var packedCombat = load("res://Combat/Combat.tscn")
var packedOverworld = load("res://Overworld/Overworld.tscn")

var party
var combatScene
var travelScene
var overworldScene
var dungeonScene
var eventScene

var shop = null

var currentScene
var prevScene
var prevSceneST


var black = Color(0, 0, 0)
var white = Color(1, 1, 1)
var red = Color(1, 0 , 0)
var green = Color(0, 1, 0)
var blue = Color(0, 0, 1)
var yellow = Color(1, 1, 0)


onready var root = get_tree().get_root()


func _ready():
	combatScene = packedCombat.instance()
	overworldScene = packedOverworld.instance()
	party = packedParty.instance()


func ChangeScene(var newScene):
	currentScene = get_tree().get_current_scene()
	
	if(newScene == combatScene):
		prevScene = currentScene
	else:
		prevSceneST = currentScene
	
	root.add_child(newScene)
	get_tree().set_current_scene(newScene)
	root.remove_child(currentScene)
	
	currentScene = newScene


func ReParentParty(var destination, var party_ = party):
	party_.get_parent().remove_child(party_)
	destination.add_child(party_)


func LoadUnitsFromBattle(var combatParty):
	while(combatParty.get_child_count()):
		combatParty.get_child(0).ReParent(party.get_node("Units"))