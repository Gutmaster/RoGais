extends "res://Unit/AdventurerCatalogue/Adventurer.gd"


func _ready():
	bpCost = 7
	unitLink = load("res://Unit/Tiki Fireballer/Tiki Fireballer.tscn").instance()