extends "res://Event/Dungeon/BaseDungeonScene.gd"


func _ready():
	LoadUnitChoice()


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()


func _on_Retrieve_pressed():
	ClearChoiceList()
	var i = 0
	while(i < $ButtonBank.get_child_count()):
		if($ButtonBank.get_child(i).is_in_group("UnitChoice")):
			ReParent($ButtonBank, choices, $ButtonBank.get_child(i))
		else:
			i += 1
	
	text.text = $TextBank/UnitChoice.text


func _on_Ignore_pressed():
	ClearChoiceList()
	ReParent($ButtonBank, choices, $ButtonBank/Proceed)
	text.text = $TextBank/Ignore.text


func MemberRetrieve(member):
	var dmg = 6 - member.aStats.Speed
	member.UpdateHealth(-dmg)
	if(member.hp > 0):
		party.gold += member.aStats.Strength
		$Container/EventMenu/Text.text = member.get_name() + " dives deep into the pool and gathers as much treasure as they can carry. Suddenly, they are swarmed by hungry pirahnas. They manage to make it out alive, bringing back " + str(member.aStats.Strength) + " gold, however they suffer " + str(dmg) + " damage in the process." 
	else:
		$EventResult.replace_by_instance()
		$Container/EventMenu/Text.text = member.get_name() + " Dives deep into the pool and gathers as much treasure as they can carry. Suddenly, they are swarmed by hungry pirahnas. They drop the treasure but are still torn to shreds before they can surface."
	
	ClearChoiceList()
	ReParent($ButtonBank, choices, $ButtonBank/Proceed)