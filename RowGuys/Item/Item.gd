extends "res://InfoBox/InfoTemplate.gd"


enum ITYPE{
artifact,
trinket,
item}

onready var iType = ITYPE.item


var power = 0

var buyPrice = 5
var sellPrice = 2


func _ready():
	pass


func _process(delta):
	pass


func Init():
	pass


func UseCheck():
	pass


func Clone():
	var temp = duplicate()
	temp.iType = ITYPE.item
	temp.Init()
	
	return temp


func _on_Item_mouse_entered():
	HoverInfo()


func _on_Item_mouse_exited():
	NoHover()