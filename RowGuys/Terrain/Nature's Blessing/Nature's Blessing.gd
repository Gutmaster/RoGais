extends "res://Terrain/TerrainCatalogue.gd"

var sproutPhase = 0
var level = 1

func _ready():
	tags.exists = true
	gClock = 2


func Init(left):
	if(!left):
		set_flip_h(true)
	animation = "Start"
	if(level >= 2):
		hp = 1
	else:
		hp = 0
	
	sproutPhase = 0
	hp += level*2
	play()
	
	for i in range(get_parent().FindOccupants().size()):
		get_parent().FindOccupants()[i].RefreshStats()


func _process(delta):
	$GrowthLabel.text = str(gClock)
	$LifeLabel.text = str(hp)


func _on_Natures_Blessing_animation_finished():
	if(gClock <= 0):
		Sprout()


func Sprout():
	gClock = 2
	sproutPhase += 1
	
	var friends = get_parent().FindOccupants()
	for i in range(friends.size()):
		friends[i].UpdateHP(+1)
		friends[i].TempPlay("Melee")
	if(level >= 2 && sproutPhase >= 2):
		stats.Endurance = 1
		stats.Strength = 1
		stats.Stamina = 100
	if(level >= 3 && sproutPhase >= 3):
		for i in range(friends.size()):
			friends[i].StatusCure()

	for i in range(friends.size()):
		friends[i].RefreshStats()