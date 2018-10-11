extends "res://Unit/AdventurerCatalogue/Adventurer.gd"


func _ready():
	bpCost = 5
	unitLink = load("res://Unit/Senor Salvadia/Senor Salvadia.tscn").instance()