extends "res://InfoBox/InfoTemplate.gd"


enum ITYPE{
artifact,
trinket,
item}

var bpCost

onready var iType = ITYPE.artifact

onready var globals = get_node("/root/Globals")
onready var party = globals.party


var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}
var enemyMod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var buyPrice = 5
var sellPrice = 2


func _ready():
	descript[0] = "Default Artifact"


func _process(delta):
	pass


func EnemyMod(unit):
	unit.Addributes(enemyMod)


func Upkeep():
	pass
	

func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.artifact
	
	return temp


func _on_Artifact_mouse_entered():
	HoverInfo()


func _on_Artifact_mouse_exited():
	NoHover()