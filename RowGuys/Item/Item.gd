extends TextureButton

onready var partyScene = get_node("/root/Globals").party

enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item

var power = 0


func _ready():
	pass


func on_Item_Pressed():
	"""if(partyScene.itemRef):
		partyScene.itemRef = self
		unit.trinket1 = partyScene.itemRef
		partyScene.itemRef = null
	elif(partyScene.itemRef == null):
		partyScene.itemRef = unit.trinket1
		unit.trinket1 = null"""
