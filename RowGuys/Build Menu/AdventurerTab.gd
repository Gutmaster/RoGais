extends TextureButton


onready var uSlots = [get_parent().find_node("USS1"), get_parent().find_node("USS2"), get_parent().find_node("USS3"), get_parent().find_node("USS4")]

func _ready():
	for i in range($AdventurerCatalogue/Grid.get_child_count()):
		var portrait = $AdventurerCatalogue/Grid.get_child(i)
		portrait.Init()
		portrait.get_node("BPCost").text = str(portrait.bpCost) + " BP"
		portrait.connect("pressed", self, "AdventurerSelected", [portrait])
	get_child(0).visible = false


func _on_AdventurerTab_pressed():
	get_child(0).visible = !get_child(0).visible


func AdventurerSelected(portrait):
	if(portrait.bpCost > get_parent().bp):
		return
		
	portrait.disabled = true
	var unit = portrait.unitLink.duplicate()
	unit.Init()
	
	for i in range(uSlots.size()):
		if(!uSlots[i].get_child_count()):
			uSlots[i].add_child(unit)
			get_parent().bp -= portrait.bpCost
			unit.get_node("Area2D").connect("unitClicked", self, "UnitUnselected", [portrait])
			return


func UnitUnselected(unit, portrait):
	get_parent().bp += portrait.bpCost
	unit.queue_free()
	portrait.disabled = false