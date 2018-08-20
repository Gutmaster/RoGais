extends TextureButton


onready var combatNode = get_node("/root/Globals").combatScene
onready var item = get_parent().get_node("Item")
onready var action = get_parent().get_node("Action")

func _ready():
	pass


func LoadStances():
	DumpStances()
	var unit = combatNode.activeUnit
	for i in range(unit.stanceList.size()):
		var stance = unit.stanceList[i].duplicate()
		$List.add_child(stance)
		stance.connect("pressed", self, "StancePressed", [stance])
		if(!stance.UseCheck()):
			stance.disabled = true
		else:
			stance.disabled = false


func DumpStances():
	while($List.get_child_count()):
		$List.remove_child($List.get_child(0))


func StancePressed(stance):
	var user = combatNode.activeUnit
	user.ChangeStance(stance)
	user.ap -= stance.apCost
	combatNode.call_deferred("PassTurn")
	action.disabled = false
	item.disabled = false
	_on_Stance_toggled(false)


func _on_Stance_toggled(button_pressed):
	pressed = button_pressed
	if(button_pressed):
		LoadStances()
		$List.show()
		action._on_Action_toggled(false)
		item._on_Item_toggled(false)
	else:
		$List.hide()