extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.artifact


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = party.itemHolder.item
	
	if(Globals.currentScene != Globals.combatScene):
		if(mouseItem != null && mouseItem.iType == type && !item):
			item = mouseItem
			party.itemHolder.remove_child(item)
			party.itemHolder.item = null
			add_child(item)
			party.artifactContainer.add_child(item)
			item.Acquire()
		elif(mouseItem == null && item):
			party.itemHolder.item = item
			item.Remove()
			party.artifactContainer.remove_child(party.artifactContainer.get_child(0))
			item = null
			party.itemHolder.itemCatcher = self
		elif(mouseItem != null && mouseItem.iType == type && item):
			party.itemHolder.remove_child(mouseItem)
			add_child(mouseItem)
			party.itemHolder.item = item
			item.Remove()
			party.artifactContainer.remove_child(party.artifactContainer.get_child(0))
			item = mouseItem
			item.Acquire()
			party.artifactContainer.add_child(item)
			party.itemHolder.itemCatcher = self
	
		party.UpdatePartyCards()
		
		if(shop):
			shop.UpdateMiniPartyCards()