extends "res://Unit/AdventurerCatalogue/Adventurer.gd"


func _ready():
	bpCost = 5
	unitLink = load("res://Unit/Dank Druid/Dank Druid.tscn").instance()