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
	combatNode.party.itemList.remove(ID)
	disabled = true