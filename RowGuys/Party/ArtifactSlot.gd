extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.artifact


func _on_Slot_focus_entered():
	release_focus()
	print("Artifact")
	
	if(partyScene.itemRef && partyScene.itemRef.iType == artifact && !item):
		item = partyScene.itemRef
		partyScene.itemRef = null
		item.Acquire()
		#partyScene.artifactContainer.add_child(item)
		#partyScene.artifactSlot.add_child(item)
	elif(partyScene.itemRef == null && item):
		item.Remove()
		partyScene.itemRef = item
		#Globals.ReParentParty(partyScene.itemHolder, partyScene.artifactSlot.get_child(1))
		item = null
		#partyScene.artifactContainer.remove_child(partyScene.artifactContainer.get_child(0))
		#partyScene.artifactSlot.remove_child(partyScene.artifactSlot.get_child(1))
	elif(partyScene.itemRef && partyScene.itemRef.iType == artifact && item):
		var tempRef = partyScene.itemRef
		item.Remove()
		partyScene.itemRef = item
		#partyScene.artifactContainer.remove_child(partyScene.artifactContainer.get_child(0))
		#partyScene.artifactSlot.remove_child(partyScene.artifactSlot.get_child(0))
		item = partyScene.tempRef
		item.Acquire()
		#partyScene.artifactContainer.add_child(item)
		#partyScene.artifactSlot.add_child(item)
		
	partyScene.UpdatePartyCards()