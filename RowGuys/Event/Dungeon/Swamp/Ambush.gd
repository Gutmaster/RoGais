extends "res://Event/EventMenu.gd"
onready var party = load("res://Party/EnemyParty.tscn")


func _ready():
	party = party.instance()
	add_child(party)
	party.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	party.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	party.AddUnit(load("res://Unit/Ent/Ent.tscn"))
	party.get_node("HUD").visible = false


func _on_Fight_pressed():
	close_event()
	get_node("/root/Globals").enemyParty = party
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").combatScene)


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()