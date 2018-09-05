extends Control


onready var unit = get_parent().unit
var connections = []
var mouseHover = false
var locked = true
var activated = false
var color = Color(0.1, 0.1, 0.1, 1)
var lvl = 0
var maxLvl = 3


func _ready():
	get_child(0).connect("pressed", self, "ActivateCheck")
	self_modulate = color


func _process(delta):
	if(!locked):
		HoverMod()


func _on_STNode_focus_entered():
	release_focus()
	ActivateCheck()


func ActivateCheck():
	if(unit.skillPoints && !locked):
		Activate()
		unit.skillPoints -= 1


func Unlock():
	locked = false
	color = Color(0.5, 0.5, 0.5, 1)


func Activate():
	if(!locked):
		if(!activated):
			activated = true
			color = Color(1, 1, 1, 1)
			for i in range(connections.size()):
				connections[i].Unlock()
		if(lvl < maxLvl):
			lvl += 1
			Apply(lvl)
			find_node("Description" + str(lvl)).Activate()


func Apply(level):
	print(level)


func AddLines():
	for i in range(connections.size()):
		var line = Line2D.new()
		line.add_point(rect_position)
		line.add_point(connections[i].rect_position)
		line.visible = true
		get_parent().add_child(line)
		get_parent().move_child(line, 1)


func HoverMod():
	if(mouseHover):
		self_modulate = Color(1,1,0.4,1)
	else:
		self_modulate = color


func _on_STNode_mouse_entered():
	mouseHover = true


func _on_STNode_mouse_exited():
	mouseHover = false