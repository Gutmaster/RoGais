extends "res://Event/EventMenu.gd"


func _ready():
	pass


func _on_FightButton_pressed():
	if(eventMenu.visible):
		close_event()
		
		get_node("/root/Globals").enemyParty = get_parent().party
		get_node("/root/Globals").travelScene = get_tree().get_current_scene()
		get_node("/root/Globals").ChangeScene(get_node("/root/Globals").combatScene)
		
		get_parent().queue_free()


func _on_RunButton_pressed():
	if(eventMenu.visible):
		print("run")
		close_event()
		get_parent().wait()