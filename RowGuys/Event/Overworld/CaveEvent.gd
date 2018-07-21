extends "res://Event/EventMenu.gd"


func _ready():
	pass


func _on_Enter_pressed():
	get_parent().LoadDungeon()


func _on_Leave_pressed():
	if(eventMenu.visible):
		print("run")
		close_event()
		get_parent().wait()
