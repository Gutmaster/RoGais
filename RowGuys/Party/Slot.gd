extends CenterContainer


enum ITYPE{
artifact,
trinket,
item}


var type = ITYPE.item
var item = null
var disabled = false

onready var party = get_node("/root/Globals").party


func _ready():
	print(get_child_count())


func _on_Slot_focus_entered():
	release_focus()
	
	if(disabled):
		return
	
	var mouseItem
	
	mouseItem = party.itemHolder.item
	
	if(mouseItem != null && !item):
		item = mouseItem
		party.itemHolder.remove_child(item)
		party.itemHolder.item = null
		add_child(item)
		
		if(Globals.shop && Globals.shop.hasShopItem):
			Globals.shop.hasShopItem = false
	elif(mouseItem == null && item):
		party.itemHolder.item = item
		print(party.itemHolder.item.description)
		item = null
		print(party.itemHolder.item.description)
		party.itemHolder.itemCatcher = self
	elif(mouseItem != null && item):
		party.itemHolder.remove_child(mouseItem)
		add_child(mouseItem)
		party.itemHolder.item = item
		item = mouseItem
		party.itemHolder.itemCatcher = self
		
		if(Globals.shop && Globals.shop.hasShopItem):
			Globals.shop.hasShopItem = false
	
	party.UpdatePartyCards()