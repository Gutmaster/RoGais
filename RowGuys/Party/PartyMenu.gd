extends "res://Party/Party.gd"


func _ready():
	pass

func _input(event):
	if(event.is_action_pressed("party_pause")):
		get_tree().paused = !(get_tree().paused)
		$Control.visible = !($Control.visible)