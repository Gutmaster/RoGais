extends "res://Event/EventMenu.gd"



func _ready():
	pass


func _on_RunButton_pressed():
	if(eventMenu.visible):
		print("run")
		close_event()
		get_parent().wait()


func _on_EnterButton_pressed():
	get_parent().LoadDungeon()
