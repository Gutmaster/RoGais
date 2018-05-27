extends "res://Terrain/TerrainCatalogue.gd"


func _ready():
	tags.exists = true
	tags.trapping = true
	maxhp = 5
	hp = maxhp


func _on_Ensnaring_Vines_animation_finished():
	if(animation == "Start"):
		animation = "Loop"