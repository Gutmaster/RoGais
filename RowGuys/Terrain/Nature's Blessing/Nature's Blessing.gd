extends "res://Terrain/TerrainCatalogue.gd"


func _ready():
	tags.exists = true
	gClock = 2
	hp = 6


func _process(delta):
	$GrowthLabel.text = str(gClock)
	$LifeLabel.text = str(hp)


func _on_Natures_Blessing_animation_finished():
	if(gClock <= 0):
		Sprout()


func Sprout():
	gClock = 2
	var victims = get_parent().FindOccupants()
	for i in range(victims.size()):
		victims[i].UpdateHP(+1)
		victims[i].TempPlay("Melee")