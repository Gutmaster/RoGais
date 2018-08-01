extends Area2D


func _ready():
	pass


"""func _input_event(viewport, event, shape_idx):
	if(!get_node("/root/Background").eventActive):
		if event is InputEventMouseButton 
		and event.button_index == BUTTON_LEFT 
		and get_parent().adjacent == true 
		and !get_parent().get_parent().moveFlag:
			get_parent().get_parent().find_node("Party").Move(get_parent())"""


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT:
		if(get_parent().adjacent == true && !get_parent().get_parent().moveFlag):
			get_parent().get_parent().find_node("Party").Move(get_parent())


func _on_Area2D_mouse_entered():
	if(!get_node("/root/Overworld").eventActive):
		get_parent().mouseHover = true


func _on_Area2D_mouse_exited():
	get_parent().mouseHover = false