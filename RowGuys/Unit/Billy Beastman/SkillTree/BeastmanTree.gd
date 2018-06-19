extends Sprite

var UNLOCK = false
var unit = null


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


func _unhandled_input(event):
	if event is InputEventKey \
	and event.pressed and event.scancode == KEY_ESCAPE:
		get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)


func _on_Regress_pressed():
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)