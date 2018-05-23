extends TextureRect

onready var partyScene = get_node("/root/Globals").party

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0


func _ready():
	pass

