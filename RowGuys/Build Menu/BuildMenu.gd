extends TextureRect


onready var globals = get_node("/root/Globals")


var bp = 20


func _ready():
	pass


func _process(delta):
	$BPCount.text = str(bp) + " BP"


func LoadBuild():
	print($AdventurerTab.uSlots.size())
	for i in range($ArtifactTab.aSlots.size()):
		if($ArtifactTab.aSlots[i].get_child_count()):
			var artifact = $ArtifactTab.aSlots[i].get_child(0)
			$ArtifactTab.aSlots[i].remove_child(artifact)
			globals.party.AddArtifact(artifact)
	for i in range($ItemTab.iSlots.size()):
		if($ItemTab.iSlots[i].get_child_count()):
			var item = $ItemTab.iSlots[i].get_child(0)
			$ItemTab.iSlots[i].remove_child(item)
			globals.party.AddItem(item)
	for i in range($AdventurerTab.uSlots.size()):
		if($AdventurerTab.uSlots[i].get_child_count()):
			var adventurer = $AdventurerTab.uSlots[i].get_child(0)
			$AdventurerTab.uSlots[i].remove_child(adventurer)
			globals.party.AddUnit(adventurer)


func _on_Embark_pressed():
	LoadBuild()
	globals.ChangeScene(globals.overworldScene)