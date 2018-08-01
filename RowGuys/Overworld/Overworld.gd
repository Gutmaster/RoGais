extends Node2D


var moveFlag = true

onready var eventActive = false
onready var globals = get_node("/root/Globals")
onready var party = globals.party


func _ready():
	add_child(get_node("/root/Globals").party)
	Init()


func Init():
	$PartyIcon.Move($Node1)


func Eat():
	for i in range(party.get_node("Units").get_child_count()):
		var unit = party.get_node("Units").get_child(i)
		if(party.food <= 0 || !unit.eatFlag):
			unit.Starve()
		else:
			unit.Eat()
			party.UpdateFood(-unit.eatRate)