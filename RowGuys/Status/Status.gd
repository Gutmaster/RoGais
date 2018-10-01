extends TextureRect

enum STATUS{
normal,
poison,
marked}

var type = null
var power = 0
onready var pwrLabel = get_node("Power")
var hunter = null

func _ready():
	pass


func Init():
	type = STATUS.normal


func Upkeep(unit):
	pass


func SelfRemove(unit):
	for i in range(unit.status.size()):
		if(unit.status[i] == self):
			unit.status.remove(i)