extends Panel


onready var combatNode = get_node("/root/Combat")


func _ready():
	pass


func Init():
	$VBoxContainer/ActionButton.disabled = false
	$VBoxContainer/ShiftButton.disabled = false
	visible = true


func _unhandled_input(event):
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_L:
		combatNode.Advance(combatNode.get_node("TeamRight"))
	if visible and event is InputEventKey \
	and event.pressed and event.scancode == KEY_R:
		combatNode.Advance(combatNode.get_node("TeamLeft"))


func _on_CommandWindow_visibility_changed():
	if(visible):
		get_parent().get_node("Advance").Check()
		$VBoxContainer/ActionButton.LoadActions()
		$VBoxContainer/StanceButton.LoadStances()
		if(combatNode.activeUnit.stats.ap <= 0):
			$VBoxContainer/ShiftButton.disabled = true
		$VBoxContainer/ShiftButton.SetOoBShift()
		rect_position = combatNode.activeUnit.position
	else:
		get_parent().get_node("Advance").Deactivate()