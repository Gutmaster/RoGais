extends "res://Status/Status.gd"

var portrait


func _ready():
	portrait = get_node("Portrait")


func Init(hun):
	power = 1
	hunter = hun
	type = STATUS.marked