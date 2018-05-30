extends TextureRect

onready var party = get_node("/root/Globals").party

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0
var iteemo = 42

var buyPrice = 5
var sellPrice = 2

func _ready():
	pass

