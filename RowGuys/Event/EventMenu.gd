extends CanvasLayer


onready var eventMenu = $Container

onready var party = get_node("/root/Globals").party
onready var choices = get_node("Container/EventMenu/ChoiceList")
onready var text = get_node("Container/EventMenu/Text")


signal partyChoice


func _ready():
	$Container.visible = false


func close_event():
	eventMenu.visible = false
	Globals.eventScene = null
	get_node("/root/Overworld").eventActive = false


func _on_Container_visibility_changed():
	$Container.rect_global_position = get_viewport().size/2 - $Container.rect_size


func ReParent(source, target, node):
	source.remove_child(node)
	target.add_child(node)


func ClearChoiceList():
	while(choices.get_child_count()):
		choices.get_child(0).queue_free()
		choices.remove_child(choices.get_child(0))


func LoadUnitChoice():
	var party = get_node("/root/Globals").party.get_node("Units")
	for i in range(party.get_child_count()):
		var button = find_node("UnitSource").duplicate()
		button.text = party.get_child(i).get_name()
		button.connect("pressed", self, "MemberRetrieve", [party.get_child(i)])
		button.add_to_group("UnitChoice")
		$ButtonBank.add_child(button)
	find_node("UnitSource").queue_free()


func _on_Proceed_pressed():
	queue_free()
	get_node("/root/Overworld").eventActive = false