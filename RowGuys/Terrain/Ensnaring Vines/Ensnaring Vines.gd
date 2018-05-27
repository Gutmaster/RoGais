extends "res://Terrain/TerrainCatalogue.gd"


func _ready():
	tags.exists = true
	gClock = 2


func _process(delta):
	if(gClock > 0):
		$GrowthLabel.text = str(gClock)
	else:
		$GrowthLabel.text = ""
	$LifeLabel.text = str(hp)


func _on_Ensnaring_Vines_animation_finished():
	if(gClock <= 0):
		Sprout()
		if(animation == "Start"):
			animation = "Loop"


func Sprout():
	var victims = get_parent().FindOccupants()
	for i in range(victims.size()):
		victims[i].UpdateHP(-1)
		victims[i].TempPlay("Stagger")
	tags.trapping = true
	maxhp = 5
	hp = maxhp