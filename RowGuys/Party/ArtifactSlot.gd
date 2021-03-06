extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.artifact


func _on_Slot_focus_entered():
	release_focus()
	
	if(disabled):
		return
	
	var mouseItem = party.itemHolder.item
	
	if(mouseItem != null && mouseItem.iType == type && !item):
		item = mouseItem
		party.itemHolder.remove_child(item)
		party.itemHolder.item = null
		add_child(item)
		party.artifactContainer.add_child(item)
		get_parent().get_node("Description").set_text(item.description)
		
		if(Globals.shop && Globals.shop.hasShopItem):
			Globals.shop.hasShopItem = false
	elif(mouseItem == null && item):
		party.itemHolder.item = item
		get_parent().get_node("Description").set_text("")
		party.artifactContainer.remove_child(party.artifactContainer.get_child(0))
		item = null
		party.itemHolder.itemCatcher = self
	elif(mouseItem != null && mouseItem.iType == type && item):
		party.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		party.itemHolder.item = item
		party.artifactContainer.remove_child(party.artifactContainer.get_child(0))
		item = mouseItem
		get_parent().get_node("Description").set_text(item.description)
		party.artifactContainer.add_child(item)
		party.itemHolder.itemCatcher = self
		
		if(Globals.shop && Globals.shop.hasShopItem):
			Globals.shop.hasShopItem = false
	
		party.UpdatePartyCards()