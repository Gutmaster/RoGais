extends TextureButton


onready var aSlots = [get_parent().find_node("ASS1"), get_parent().find_node("ASS2")]

func _ready():
	for i in range(1, $ArtifactCatalogue/Grid.get_child_count()):
		var artifact = $ArtifactCatalogue/Grid.get_child(i)
		artifact.get_node("BPCost").text = str(artifact.bpCost) + " BP"
		artifact.connect("pressed", self, "ArtifactSelected", [artifact], CONNECT_ONESHOT)
	get_child(0).visible = false


func _on_ArtifactTab_pressed():
	get_child(0).visible = !get_child(0).visible


func ArtifactSelected(artifact):
	if(artifact.bpCost > get_parent().bp):
		return
	
	for i in range(aSlots.size()):
		if(!aSlots[i].get_child_count()):
			artifact.get_parent().remove_child(artifact)
			aSlots[i].add_child(artifact)
			get_parent().bp -= artifact.bpCost
			artifact.connect("pressed", self, "ArtifactUnselected", [artifact], CONNECT_ONESHOT)
			return


func ArtifactUnselected(artifact):
	get_parent().bp += artifact.bpCost
	
	artifact.get_parent().remove_child(artifact)
	$ArtifactCatalogue/Grid.add_child(artifact)
	
	artifact.connect("pressed", self, "ArtifactSelected", [artifact], CONNECT_ONESHOT)