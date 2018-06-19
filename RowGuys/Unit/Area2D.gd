extends Area2D


signal unitClicked


func _ready():
	pass
	#print(get_parent().get_node("ActionCatalogue/Feral Fling").get_name(), "CONNECTO")
	#get_parent().get_node("ActionCatalogue/Feral Fling").connect("unitClicked", self, "Target")


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		get_parent().combatNode.hoverUnit = get_parent()
	elif event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT:
		emit_signal("unitClicked", get_parent())
		var Action = get_node("/root/Combat/HUD/CommandWindow/VBoxContainer/ActionButton")
		if(Action.targetMode):
			Action.target = get_parent()

"""
func _on_Area2D_mouse_entered():
	get_parent().mouseHover = true

"""
func _on_Area2D_mouse_exited():
	#if(get_parent().combatNode.hoverUnit == self):
		get_parent().combatNode.hoverUnit = null
