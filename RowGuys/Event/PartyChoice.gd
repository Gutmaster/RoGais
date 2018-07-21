extends "res://Event/EventMenu.gd"


func _ready():
	var party = get_node("/root/Globals").party.get_node("Units")
	for i in range(party.get_child_count()):
		var button = find_node("Example").duplicate()
		button.text = party.get_child(i).get_name()
		button.connect("pressed", get_parent(), "MemberRetrieve", [party.get_child(i)])
		find_node("Buttons").add_child(button)
	
	find_node("Example").queue_free()
	$Container.visible = true


func close_event():
	queue_free()