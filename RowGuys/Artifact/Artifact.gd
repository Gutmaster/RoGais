extends TextureRect


enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.artifact

onready var globals = get_node("/root/Globals")
onready var party = globals.party


var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var enemyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var description = ""


func _ready():
	pass


func Acquire():
	party.find_node("Description").set_text(description)


func Remove():
	party.find_node("Description").set_text("")


func EnemyMod(unit):
	unit.Addributes(enemyMod)


func Upkeep():
	pass