extends TextureButton


onready var iSlots = [get_parent().find_node("ISS1"), get_parent().find_node("ISS2"), get_parent().find_node("ISS3"), get_parent().find_node("ISS4")]

func _ready():
	for i in range(1, $ItemCatalogue/Grid.get_child_count()):
		var item = $ItemCatalogue/Grid.get_child(i)
		item.get_node("BPCost").text = str(item.bpCost) + " BP"
		item.connect("pressed", self, "ItemSelected", [item], CONNECT_ONESHOT)
	get_child(0).visible = false


func _on_ItemTab_pressed():
	get_child(0).visible = !get_child(0).visible


func ItemSelected(item):
	if(item.bpCost > get_parent().bp):
		return
	
	for i in range(iSlots.size()):
		if(!iSlots[i].get_child_count()):
			item.get_parent().remove_child(item)
			iSlots[i].add_child(item)
			get_parent().bp -= item.bpCost
			item.connect("pressed", self, "ItemUnselected", [item], CONNECT_ONESHOT)
			return


func ItemUnselected(item):
	get_parent().bp += item.bpCost
	
	item.get_parent().remove_child(item)
	$ItemCatalogue/Grid.add_child(item)
	
	item.connect("pressed", self, "ItemSelected", [item], CONNECT_ONESHOT)