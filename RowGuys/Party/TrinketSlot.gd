extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.trinket


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
		call_deferred("remove_child", item)
		partyScene.itemHolder.item = item
		item.Remove()
		item = null
	elif(mouseItem != null && mouseItem.iType == type && item):
		partyScene.itemHolder.remove_child(mouseItem)
		remove_child(item)
		partyScene.itemHolder.add_child(item)
		add_child(mouseItem)
		var tempRef = mouseItem
		mouseItem = item
		item = tempRef
		mouseItem.Remove()
		item.Acquire()
	
	partyScene.UpdatePartyCards()