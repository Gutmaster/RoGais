extends "res://Unit/SkillTreeBase.gd"


func _ready():
	$FireCrackerFlip.connections.push_back($"LeapingStrike")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	
	$"FireCrackerFlip".Unlock()
	$LevelCard.Init(unit)


func _process(delta):
	.process()