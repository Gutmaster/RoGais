extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.trinket


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = party.itemHolder.item
	
	if(Globals.currentScene != Globals.combatScene):
		if(mouseItem != null && mouseItem.iType == type && !item):
			item = mouseItem
			party.itemHolder.remove_child(item)
			party.itemHolder.item = null
			add_child(item)
			
			if(Globals.shop && Globals.shop.hasShopItem):
				Globals.shop.hasShopItem = false
		elif(mouseItem == null && item):
			party.itemHolder.item = item
			item = null
			party.itemHolder.itemCatcher = self
		elif(mouseItem != null && mouseItem.iType == type && item):
			party.itemHolder.remove_child(mouseItem)
			add_child(mouseItem)
			party.itemHolder.item = item
			item = mouseItem
			party.itemHolder.itemCatcher = self
			
			if(Globals.shop && Globals.shop.hasShopItem):
				Globals.shop.hasShopItem = false
	
		party.UpdatePartyCards()