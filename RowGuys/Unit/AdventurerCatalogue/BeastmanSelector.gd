extends "res://Unit/AdventurerCatalogue/Adventurer.gd"


func _ready():
	bpCost = 6
	unitLink = load("res://Unit/Billy Beastman/Billy Beastman.tscn").instance()