extends "res://Event/EventMenu.gd"


func _ready():
	pass


func _on_Continue_pressed():
	queue_free()
	get_node("/root/Dungeon").eventActive = false

func _on_Proceed_pressed():
	pass # replace with function body
