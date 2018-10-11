extends Area2D


signal unitClicked


func _ready():
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		get_parent().combatNode.hoverUnit = get_parent()
	elif event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT:
		emit_signal("unitClicked", get_parent())
		var Action = get_node("/root/Combat/HUD/CommandWindow/Action")
		if(Action!= null && Action.targetMode):
			Action.target = get_parent()

"""
func _on_Area2D_mouse_entered():
	get_parent().mouseHover = true

"""
func _on_Area2D_mouse_exited():
	#if(get_parent().combatNode.hoverUnit == self):
		get_parent().combatNode.hoverUnit = null
		var anchor = get_parent().combatNode.get_node("HUD/UnitInfoAnchor")
		if(anchor.get_child(0)):
			get_parent().combatNode.RemoveInfo()
