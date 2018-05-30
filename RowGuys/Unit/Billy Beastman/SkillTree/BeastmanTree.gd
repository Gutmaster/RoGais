extends Sprite


var unit = null


func _ready():
	"""$"Nature's Blessing".connections.push_back($"Minor Beast")
	$"Nature's Blessing".connections.push_back($"Ensnaring Vines")
	
	$"Ensnaring Vines".connections.push_back($"Reclaim")
	$"Reclaim".connections.push_back($"Ensnaring Vines")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()"""
	
	
	$"Retaliate".Unlock()


func _unhandled_input(event):
	if event is InputEventKey \
	and event.pressed and event.scancode == KEY_ESCAPE:
		get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)


func _on_Regress_pressed():
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)