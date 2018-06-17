extends MenuButton


onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	get_popup().connect("id_pressed", self, "_on_Item_id_pressed")
	get_popup().add_font_override("font",load("res://Fonts/CommandFont.tres"))


func LoadItems():
	get_popup().clear()
	
	var iList = combatNode.party.itemList
	for i in range(iList.size()):
		if(iList[i].item != null && iList[i].item.iType == combatNode.party.ITYPE.item):
			get_popup().add_item(iList[i].item.get_name(), i)


func _on_Item_id_pressed(ID):
	combatNode.party.itemList[ID].item.Use(combatNode.activeUnit)
	combatNode.activeUnit.TempPlay("Toss")
	
	var item = combatNode.party.itemList[ID].item
	#combatNode.party.itemList.remove(ID)
	disabled = true
	
	var found = false
	
	for i in range(1, 8):
		if(!found):
			var slot = combatNode.party.itemList[i]
			
			if(slot.item == item):
				found = true
				slot.remove_child(item)
				slot.item = null