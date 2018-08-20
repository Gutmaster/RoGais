extends TextureButton

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


func UseCheck():
	pass


func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.item
	temp.Init()
	
	return temp