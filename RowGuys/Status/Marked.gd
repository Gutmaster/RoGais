extends "res://Status/Status.gd"

var portrait


func _ready():
	portrait = get_node("Hunter")


func Init(hun):
	power = 1
	hunter = hun
	portrait = hun.portrait
	type = STATUS.marked