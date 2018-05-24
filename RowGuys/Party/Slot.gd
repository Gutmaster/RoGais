extends CenterContainer


enum ITYPE{
artifact,
trinket,
item}


onready var type = ITYPE.item
onready var item = null

onready var partyScene = get_node("/root/Globals").party


func _ready():
	print(get_child_count())
	pass


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = partyScene.itemHolder.item
	
	if(mouseItem != null && !item):
		item = mouseItem
		partyScene.itemHolder.remove_child(item)
		partyScene.itemHolder.item = null
		add_child(item)
	elif(mouseItem == null && item):
		partyScene.itemHolder.item = item
		item = null
	elif(mouseItem != null && item):
		partyScene.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		partyScene.itemHolder.item = item
		item = mouseItem
	
	partyScene.UpdatePartyCards()