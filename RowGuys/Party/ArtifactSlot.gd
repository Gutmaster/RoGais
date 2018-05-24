extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.artifact


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = partyScene.itemHolder.item
	
	if(mouseItem != null && mouseItem.iType == type && !item):
		item = mouseItem
		partyScene.itemHolder.remove_child(item)
		partyScene.itemHolder.item = null
		add_child(item)
		item.Acquire()
	elif(mouseItem == null && item):
		partyScene.itemHolder.item = item
		item.Remove()
		item = null
	elif(mouseItem != null && mouseItem.iType == type && item):
		partyScene.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		partyScene.itemHolder.item = item
		item.Remove()
		item = mouseItem
		item.Acquire()
	
	partyScene.UpdatePartyCards()