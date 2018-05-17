extends TextureRect


enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.trinket

var mod = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}



func _ready():
	pass


func Upkeep():
	pass