extends "res://Party/Slot.gd"


#onready var itemHolder = find_node("Shop").itemHolder


func _ready():
	type = ITYPE.item


func _on_Slot_focus_entered():
	release_focus()
	
	var itemHolder = shop.itemHolder
	var mouseItem = itemHolder.item
	
	if(mouseItem == null && item && party.gold >= item.buyPrice):
		mouseItem = item
		itemHolder.add_child(mouseItem)
		item = null
		itemHolder.itemCatcher = get_parent()
	#elif(mouseItem && !item && itemHolder.itemCatcher == get_parent()):
		

	shop.UpdateMiniPartyCards()