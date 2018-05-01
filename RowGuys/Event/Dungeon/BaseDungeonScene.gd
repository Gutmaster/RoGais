extends "res://Event/EventMenu.gd"


onready var party = get_node("/root/Globals").party


func _ready():
	pass


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()


func DisableButtons():
	var buttons = get_tree().get_nodes_in_group("Buttons")
	for i in buttons:
		i.disabled = true