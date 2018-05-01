extends Node2D

var scrollDir = null


func _ready():
	pass


func _process(delta):
	var pos1 = $BG1.position.x
	var pos2 = $BG2.position.x
	var row = get_parent().get_node("Row")
	
	if(scrollDir == get_parent().SIDE.left):
		$BG1.position.x -= 8
		$BG2.position.x -= 8
		for i in range(row.get_child_count()):
			row.get_child(i).terrain.position.x -= 8
			
		if($BG1.position.x < 0 && pos1 >= 0 && $BG2.position.x < $BG1.position.x):
			LoopRight($BG1, $BG2)
		elif($BG2.position.x < 0 && pos2 >= 0 && $BG1.position.x < $BG2.position.x):
			LoopRight($BG2, $BG1)
	elif(scrollDir == get_parent().SIDE.right):
		$BG1.position.x += 8
		$BG2.position.x += 8
		for i in range(row.get_child_count()):
			row.get_child(i).terrain.position.x += 8
		
		
		if($BG1.position.x > 0 && pos1 <= 0 && $BG2.position.x > $BG1.position.x):
			LoopLeft($BG1, $BG2)
		elif($BG2.position.x > 0 && pos2 <= 0 && $BG1.position.x > $BG2.position.x):
			LoopLeft($BG2, $BG1)


func LoopLeft(Stay, Loop):
	Loop.position.x = Stay.position.x - Loop.texture.get_width()


func LoopRight(Stay, Loop):
	Loop.position.x = Stay.position.x + Stay.texture.get_width()