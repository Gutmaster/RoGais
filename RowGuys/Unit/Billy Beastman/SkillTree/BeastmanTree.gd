extends "res://Unit/SkillTreeBase.gd"


var UNLOCK = false


func _ready():
	$"Retaliate".connections.push_back($"Feral Fling")
	$"Feral Fling".connections.push_back($"Frenzy")
	$"Frenzy".connections.push_back($"Bloodsong")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	
	$"Retaliate".Unlock()
	
	if(UNLOCK):
		$"Feral Fling".Unlock()
		$"Feral Fling".Apply(1)
		$"Feral Fling".Apply(2)
		$"Feral Fling".Apply(3)
		$"Frenzy".Unlock()
		$"Frenzy".Apply(1)
		$"Frenzy".Apply(2)
		$"Frenzy".Apply(3)
	
	$LevelCard.Init(unit)


func _process(delta):
	.process()