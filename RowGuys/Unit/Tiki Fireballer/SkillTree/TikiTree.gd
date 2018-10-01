extends "res://Unit/SkillTreeBase.gd"


func _ready():
	$Fireball.connections.push_back($"Fire Dance")
	#$"Fire Dance".connections.push_back($Rift)
	$"Fire Dance".connections.push_back($Fasting)
	$Fasting.connections.push_back($Rift)
	$"Fire Dance".connections.push_back($"Palm Strike")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	$"Fireball".Unlock()
	$LevelCard.Init(unit)


func _process(delta):
	.process()