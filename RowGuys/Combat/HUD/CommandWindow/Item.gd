extends TextureButton

var mouseHover = false

onready var combatNode = get_node("/root/Globals").combatScene
onready var action = get_parent().get_node("Action")
onready var stance = get_parent().get_node("Stance")
onready var globals = get_node("/root/Globals")


func _ready():
	pass


func _process(delta):
	if(mouseHover):
		self_modulate = globals.yellow
	else:
		self_modulate = globals.white


func LoadItems():
	DumpItems()
	var iList = combatNode.party.itemList
	for i in range(iList.size()):
		if(iList[i].item == null):
			continue
		
		var item = iList[i].item.Clone()
		if(item != null && item.iType == combatNode.party.ITYPE.item):
			$List.add_child(item)
			item.connect("pressed", self, "ItemPressed", [iList[i].item])
			item.mouse_filter = MOUSE_FILTER_PASS
			item.UseCheck()


func DumpItems():
	while($List.get_child_count()):
		$List.remove_child($List.get_child(0))


func ItemPressed(item):
	item.Use(combatNode.activeUnit)
	combatNode.activeUnit.TempPlay("Toss")
	
	disabled = true
	_on_Item_toggled(false)
	
	var found = false
	
	for i in range(7):
		if(!found):
			var slot = combatNode.party.itemList[i]
			
			if(slot.item == item):
				found = true
				slot.remove_child(item)
				slot.item = null


func _on_Item_toggled(button_pressed):
	pressed = button_pressed
	if(button_pressed):
		LoadItems()
		$List.show()
		stance._on_Stance_toggled(false)
		action._on_Action_toggled(false)
	else:
		$List.hide()


func _on_Item_mouse_entered():
	mouseHover = true


func _on_Item_mouse_exited():
	mouseHover = false