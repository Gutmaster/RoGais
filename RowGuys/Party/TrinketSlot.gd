extends "res://Party/Slot.gd"


func _ready():
	type = ITYPE.trinket


func _on_Slot_focus_entered():
	release_focus()
	print("Trinket")
	
	if(partyScene.itemRef && partyScene.itemRef.iType == trinket && !item):
		item = partyScene.itemRef
		partyScene.itemRef = null
		#item.Acquire()
		#partyScene.artifactContainer1.add_child(item)
		#partyScene.artifactContainer2.add_child(item)
	elif(partyScene.itemRef == null && item):
		#item.Remove()
		partyScene.itemRef = item
		item = null
		#partyScene.artifactContainer1.remove_child(partyScene.artifactContainer1.get_child(0))
		#partyScene.artifactContainer2.remove_child(partyScene.artifactContainer2.get_child(0))
	elif(partyScene.itemRef && partyScene.itemRef.iType == trinket && item):
		var tempRef = partyScene.itemRef
		#item.Remove()
		partyScene.itemRef = item
		#partyScene.artifactContainer1.remove_child(partyScene.artifactContainer1.get_child(0))
		#partyScene.artifactContainer2.remove_child(partyScene.artifactContainer2.get_child(0))
		item = partyScene.tempRef
		#item.Acquire()
		#partyScene.artifactContainer1.add_child(item)
		#partyScene.artifactContainer2.add_child(item)
		
	#partyScene.UpdatePartyCards()