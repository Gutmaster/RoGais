extends Sprite


var unit = null


func _ready():
	$"Retaliate".connections.push_back($"Feral Fling")
	
	var skillnodes = get_tree().get_nodes_in_group("skillnodes")
	for i in skillnodes:
		i.AddLines()
	
	
	$"Retaliate".Unlock()


func _unhandled_input(event):
	if event is InputEventKey \
	and event.pressed and event.scancode == KEY_ESCAPE:
		get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)


func _on_Regress_pressed():
	get_node("/root/Globals").ChangeScene(get_node("/root/Globals").prevSceneST)