extends "res://Overworld/Scripts/Objects/OverworldObject.gd"
onready var party = load("res://Party/EnemyParty.tscn")


func _ready():
	LoadParty()


func LoadParty():
	party = party.instance()
	add_child(party)
	party.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	party.AddUnit(load("res://Unit/Froggodile/Froggodile.tscn"))
	party.AddUnit(load("res://Unit/Ent/Ent.tscn"))
	party.get_node("PanelContainer").visible = false


func AddUnit(var unit):
	unit = unit.instance()
	unit.CharCardInit()
	get_node("Party").add_child(unit, true)