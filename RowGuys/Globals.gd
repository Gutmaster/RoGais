extends Node


var enemyParty

var packedParty = load("res://Party/Party.tscn")
var packedCombat = load("res://Combat/Combat.tscn")
var packedTravel = load("res://Overworld/Travel.tscn")

var party
var combatScene
var travelScene
var dungeonScene

var currentScene
var prevScene
var prevSceneST

onready var root = get_tree().get_root()


func _ready():
	combatScene = packedCombat.instance()
	travelScene = packedTravel.instance()
	party = packedParty.instance()
	
	LoadParty()


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


func LoadParty():
	party.AddUnit(load("res://Unit/Senor Salvadia/Senor Salvadia.tscn"))
	party.AddUnit(load("res://Unit/Billy Beastman/Billy Beastman.tscn"))
	party.AddUnit(load("res://Unit/Dank Druid/Dank Druid.tscn"))
	party.AddUnit(load("res://Unit/Tiki Fireballer/Tiki Fireballer.tscn"))


func ReParentParty(var destination, var party_ = party):
	party_.get_parent().remove_child(party_)
	destination.add_child(party_)


func LoadUnitsFromBattle(var combatParty):
	while(combatParty.get_child_count()):
		combatParty.get_child(0).ReParent(party.get_node("Units"))