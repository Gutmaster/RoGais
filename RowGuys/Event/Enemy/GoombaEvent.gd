extends "res://Event/EventMenu.gd"


onready var eParty = load("res://Party/EnemyParty.tscn")


func _ready():
	eParty = eParty.instance()
	add_child(eParty)
	eParty.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	eParty.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	eParty.AddUnit(load("res://Unit/Ent/Ent.tscn"))
	eParty.get_node("HUD").visible = false


func _on_Fight_pressed():
	close_event()
	get_node("/root/Globals").enemyParty = eParty
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").combatScene)


func close_event():
	get_node("/root/Overworld").eventActive = false
	queue_free()


func _on_Retreat_pressed():
	if(eventMenu.visible):
		close_event()