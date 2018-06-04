extends "res://Status/Status.gd"

var portrait


func _ready():
	portrait = get_node("Portrait")


func Init(hun):
	hunter = hun
	type = STATUS.marked