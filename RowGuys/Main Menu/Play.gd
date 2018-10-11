extends TextureButton


onready var globals = get_node("/root/Globals")


func _ready():
	pass


func _on_Play_pressed():
	get_parent().remove_child(globals.party)
	globals.ChangeScene(globals.buildScene)


func LoadParty():
	var party = get_node("/root/Globals").party
	party.AddUnit(load("res://Unit/Senor Salvadia/Senor Salvadia.tscn"))
	party.AddUnit(load("res://Unit/Billy Beastman/Billy Beastman.tscn"))
	party.AddUnit(load("res://Unit/Dank Druid/Dank Druid.tscn"))
	party.AddUnit(load("res://Unit/Tiki Fireballer/Tiki Fireballer.tscn"))