extends "res://Event/EventMenu.gd"

func _ready():
	pass


func _on_ShopButton_pressed():
	pass # replace with function body


func _on_ExitButton_pressed():
	if(eventMenu.visible):
		print("exit")
		close_event()
		get_parent().wait()
