extends TextureRect

func _ready():
	set_focus_mode(FOCUS_ALL)
	pass


func _on_Loss_visibility_changed():
	if(is_visible()):
		grab_focus()
