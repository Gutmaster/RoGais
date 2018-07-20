extends AnimatedSprite

var tags = {"exists": false, "blocking": false, "target": false, "trapping": false}
var stats = {"Vitality" : 0, "Stamina" : 0, "Strength" : 0, "Wisdom" : 0, "Endurance" : 0, "Willpower" : 0, "Speed" : 0}

var maxhp = 10
var hp = 10

var gClock = 0
var level = 0

func _ready():
	position = Vector2(0, 0)


func Init(left):
	if(!left):
		set_flip_h(true)
	animation = "Start"
	play()


func Upkeep():
	hp -= 1
	if(hp <= 0):
		get_parent().ClearTerrain()
		return false
	
	return true