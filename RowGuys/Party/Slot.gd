extends CenterContainer


enum ITYPE{
artifact,
trinket,
item}


onready var type = ITYPE.item
onready var item = null

onready var party = get_node("/root/Globals").party


func _ready():
	print(get_child_count())
	pass


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = party.itemHolder.item
	
	if(mouseItem != null && !item):
		item = mouseItem
		party.itemHolder.remove_child(item)
		party.itemHolder.item = null
		add_child(item)
	elif(mouseItem == null && item):
		party.itemHolder.item = item
		item = null
		party.itemHolder.itemCatcher = self
	elif(mouseItem != null && item):
		party.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		party.itemHolder.item = item
		item = mouseItem
		party.itemHolder.itemCatcher = self
	
	party.UpdatePartyCards()