extends MenuButton


onready var combatNode = get_node("/root/Globals").combatScene


func _ready():
	get_popup().connect("id_pressed", self, "_on_Item_id_pressed")
	get_popup().add_font_override("font",load("res://Fonts/CommandFont.tres"))


func LoadItems():
	get_popup().clear()
	
	for i in range(combatNode.party.itemList.size()):
		get_popup().add_item(combatNode.party.itemList[i].get_name(), i)


func _on_Item_id_pressed(ID):
	combatNode.party.itemList[ID].Use(combatNode.activeUnit)
	combatNode.activeUnit.TempPlay("Toss")
	combatNode.activeUnit.animFlag = combatNode.activeUnit.ANIMFLAG.command
	var item = combatNode.party.itemList[ID]
	combatNode.party.itemList.remove(ID)
	disabled = true
	
	var found = false
	
	for i in range(1, 8):
		if(!found):
			var slotString = "Slot" + str(i)
			var slot = combatNode.party.find_node(slotString)
			
			if(slot.item == item):
				found = true
				slot.remove_child(item)
				slot.item = null