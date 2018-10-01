extends "res://Unit/SkillTreeBase.gd"


func _ready():
	$LeapingStrike.connections.push_back($Lasso)
	$LeapingStrike.connections.push_back($Evade)
	$Lasso.connections.push_back($FireCrackerFlip)
	$Lasso.connections.push_back($Cleave)
	$Evade.connections.push_back($FireCrackerFlip)
	#$FireCrackerFlip.connections.push_back($LeapingStrike)
	#$FireCrackerFlip.connections.push_back($Lasso)
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	
	$LeapingStrike.Unlock()
	$LevelCard.Init(unit)


func _process(delta):
	.process()