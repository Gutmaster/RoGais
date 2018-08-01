extends Area2D


func _ready():
	pass


func _input_event(viewport, event, shape_idx):
	if(!get_node("/root/Overworld").eventActive):
		if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and !get_parent().get_parent().moveFlag:
			get_parent().get_parent().find_node("PartyIcon").Move(get_parent())


func _on_Area2D_mouse_entered():
	if(!get_node("/root/Overworld").eventActive):
		get_parent().mouseHover = true


func _on_Area2D_mouse_exited():
	get_parent().mouseHover = false