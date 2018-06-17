extends TextureRect


enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.trinket

var description

var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var buyPrice = 5
var sellPrice = 2

func _ready():
	pass


func Init():
	pass


func Upkeep(unit):
	pass


func PullRandom():
	randomize()
	return get_child(randi()%get_child_count())


func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.trinket
	temp.Init()
	
	return temp