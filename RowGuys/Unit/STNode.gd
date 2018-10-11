extends Control


onready var unit = get_parent().unit
var connections = []
var mouseHover = false
var locked = true
var activated = false
var color = Color(0.2, 0.2, 0.2, 1)
var lvl = 0
var maxLvl = 3
onready var action = get_child(0)


func _ready():
	action.connect("pressed", self, "ActivateCheck")
	action.modulate = color


func _process(delta):
	if(!locked):
		HoverMod()


func ActivateCheck():
	if(unit.skillPoints && !locked && lvl < maxLvl):
		Activate()


func Unlock():
	locked = false
	color = Color(0.5, 0.5, 0.5, 1)


func Activate():
	if(!locked):
		if(!activated):
			activated = true
			color = Color(1, 1, 1, 1)
			for i in range(connections.size()):
				if(connections[i].locked):
					connections[i].Unlock()
		if(lvl < maxLvl):
			unit.skillPoints -= 1
			lvl += 1
			Apply(lvl)


func Apply(level):
	action.descriptBox.get_node("Level" + str(lvl)).set("custom_colors/font_color", (Color(1, 1, 1)))


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
		get_child(0).modulate = Color(1,1,0.4,1)
	else:
		get_child(0).modulate = color


func _on_STNode_mouse_entered():
	mouseHover = true


func _on_STNode_mouse_exited():
	mouseHover = false