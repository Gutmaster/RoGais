extends "res://Terrain/TerrainCatalogue.gd"


func _ready():
	tags.exists = true
	tags.blocking = true
	tags.target = true
	maxhp = 10
	hp = maxhp


func _process(delta):
	get_node("HPBar").set_value((float(hp)/maxhp) * 100)


func _on_Earth_Barrier_animation_finished():
	if(animation == "Start"):
		animation = "Loop"
