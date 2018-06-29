extends TextureRect

onready var party = get_node("/root/Globals").party

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0

var buyPrice = 5
var sellPrice = 2

var description = ""


func _ready():
	pass


func Init():
	pass


func PullRandom():
	randomize()
	return get_child(randi()%get_child_count()).Clone()


func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.item
	temp.Init()
	
	return temp