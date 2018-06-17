extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.item


func _on_Slot_focus_entered():
	release_focus()
	
	var mouseItem = party.itemHolder.item
	
	if(mouseItem == null && item && party.gold >= item.buyPrice):
		party.itemHolder.item = item
		party.itemHolder.add_child(mouseItem)
		party.UpdateGold(-(item.buyPrice))
		item = null
		Globals.shop.hasShopItem = true
	elif(Globals.shop.hasShopItem && !item):
		party.UpdateGold(party.itemHolder.item.buyPrice)
		Globals.shop.hasShopItem = false
		party.itemHolder.remove_child(party.itemHolder.item)
		Globals.shop.AddShopItem(party.itemHolder.item)
		party.itemHolder.item = null
		
		
		
		
		
		