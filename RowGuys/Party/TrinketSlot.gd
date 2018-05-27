extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.trinket


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = party.itemHolder.item
	
	if(mouseItem != null && mouseItem.iType == type && !item):
		item = mouseItem
		party.itemHolder.remove_child(item)
		party.itemHolder.item = null
		add_child(item)
		item.Acquire()
	elif(mouseItem == null && item):
		party.itemHolder.item = item
		item.Remove()
		item = null
		party.itemHolder.itemCatcher = self
	elif(mouseItem != null && mouseItem.iType == type && item):
		party.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		party.itemHolder.item = item
		item.Remove()
		item = mouseItem
		item.Acquire()
		party.itemHolder.itemCatcher = self
	
	party.UpdatePartyCards()