extends "res://Event/Dungeon/BaseDungeonScene.gd"


func _ready():
	pass


func close_event():
	get_node("/root/Dungeon").eventActive = false
	queue_free()


func _on_Retrieve_pressed():
	DisableButtons()
	$PartyChoice.replace_by_instance()


func _on_Ignore_pressed():
	DisableButtons()
	$EventResult.replace_by_instance()
	$EventResult/Container/EventResult/Text.text = "There's no telling what's in that water. Time to leave."


func MemberRetrieve(member):
	var dmg = 6 - member.aStats.Speed
	member.UpdateHealth(-dmg)
	if(member.hp > 0):
		party.gold += member.aStats.Strength
		$EventResult.replace_by_instance()
		$EventResult/Container/EventResult/Text.text = member.get_name() + " Dives deep into the pool and gathers as much treasure as they can carry. Suddenly, they are swarmed by hungry pirahnas. They manage to make it out alive, bringing back " + str(member.aStats.Strength) + " gold, however they suffer " + str(dmg) + " damage in the process." 
	else:
		$EventResult.replace_by_instance()
		$EventResult/Container/EventResult/Text.text = member.get_name() + " Dives deep into the pool and gathers as much treasure as they can carry. Suddenly, they are swarmed by hungry pirahnas. They drop the treasure but are still torn to shreds before they can surface."