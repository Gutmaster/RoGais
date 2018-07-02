extends "res://Unit/SkillTreeBase.gd"


func _ready():
	$"Nature's Blessing".connections.push_back($"Minor Beast")
	$"Nature's Blessing".connections.push_back($"Ensnaring Vines")
	
	$"Ensnaring Vines".connections.push_back($"Reclaim")
	$"Reclaim".connections.push_back($"Ensnaring Vines")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	
	$"Nature's Blessing".Unlock()
	$LevelCard.Init(unit)


func _process(delta):
	.process()