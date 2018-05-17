extends TextureRect


enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.artifact

onready var globals = get_node("/root/Globals")
onready var party = globals.party


var partyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var enemyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var description = ""

onready var emptyPortrait = load("res://Unit/placeholder.png")


func _ready():
	pass


func Acquire():
	for i in range(party.find_node("Units").get_child_count()):
		var unit = party.find_node("Units").get_child(i)
		unit.Addributes(partyMod)


func Remove():
	for i in range(party.find_node("Units").get_child_count()):
		var unit = party.find_node("Units").get_child(i)
		unit.Subtributes(partyMod)


func EnemyMod(unit):
	unit.Addributes(enemyMod)


func Upkeep():
	pass