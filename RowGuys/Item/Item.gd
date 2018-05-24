extends TextureRect

onready var party = get_node("/root/Globals").party

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0
var iteemo = 42

func _ready():
	pass

