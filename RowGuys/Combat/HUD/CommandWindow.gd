extends Panel


onready var combatNode = get_node("/root/Combat")


func _ready():
	pass


func Init():
	$VBoxContainer/ActionButton.disabled = false
	$VBoxContainer/ShiftButton.disabled = false
	$VBoxContainer/ItemButton.disabled = false
	visible = true


func _unhandled_input(event):
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_L:
		combatNode.Advance(combatNode.get_node("TeamRight"))
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_R:
		combatNode.Advance(combatNode.get_node("TeamLeft"))
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_DELETE:
		var loopo = true
		while loopo:
			loopo = false
			for i in range(combatNode.uList.get_child_count()):
				if(combatNode.uList.get_child(i).teamLeft == false):
					combatNode.uList.get_child(i).UpdateHP(-100)
					loopo = true
					break


func _on_CommandWindow_visibility_changed():
	if(visible):
		get_parent().get_node("Advance").Check()
		$VBoxContainer/ActionButton.LoadActions()
		$VBoxContainer/StanceButton.LoadStances()
		$VBoxContainer/ItemButton.LoadItems()
		if(combatNode.activeUnit.ap <= 0):
			$VBoxContainer/ShiftButton.disabled = true
		$VBoxContainer/ShiftButton.SetOoBShift()
		#rect_position = combatNode.activeUnit.position
	else:
		get_parent().get_node("Advance").Deactivate()