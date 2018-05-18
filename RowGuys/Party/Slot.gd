extends CenterContainer


enum ITYPE{
artifact,
trinket,
item}


onready var type = ITYPE.item
onready var item = null

onready var partyScene = get_node("/root/Globals").party

func _ready():
	pass


func _on_Slot_focus_entered():
	release_focus()
	print("Item")
	
	if(partyScene.itemRef && !item):
		item = partyScene.itemRef
		partyScene.itemRef = null
	elif(partyScene.itemRef == null && item):
		partyScene.itemRef = item
		item = null
	elif(partyScene.itemRef && item):
		var tempRef = partyScene.itemRef
		partyScene.itemRef = item
		item = partyScene.itemRef
		
		