extends TextureButton

var mouseHover = false

onready var combatNode = get_node("/root/Globals").combatScene
onready var item = get_parent().get_node("Item")
onready var action = get_parent().get_node("Action")
onready var globals = get_node("/root/Globals")


func _ready():
	pass


func _process(delta):
	if(mouseHover):
		self_modulate = globals.yellow
	else:
		self_modulate = globals.white


func LoadStances():
	DumpStances()
	var unit = combatNode.activeUnit
	for i in range(unit.stanceList.size()):
		var stance = unit.stanceList[i]
		stance.parent.remove_child(stance)
		$List.add_child(stance)
		stance.connect("pressed", self, "StancePressed", [stance])
		if(!stance.UseCheck()):
			stance.disabled = true
		else:
			stance.disabled = false


func DumpStances():
	while($List.get_child_count()):
		var stance = $List.get_child(0)
		$List.remove_child(stance)
		stance.parent.add_child(stance)


func StancePressed(stance):
	var user = combatNode.activeUnit
	user.ChangeStance(stance)
	user.ap -= stance.apCost
	combatNode.call_deferred("PassTurn")
	stance.mouseHover = false
	stance.infoBox.visible = false
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


func _on_Stance_mouse_entered():
	mouseHover = true


func _on_Stance_mouse_exited():
	mouseHover = false
