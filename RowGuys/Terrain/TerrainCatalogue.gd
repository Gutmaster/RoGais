extends AnimatedSprite

var tags = {"exists": false, "blocking": false, "target": false, "trapping": false}

var maxhp = 10
var hp = 10

var gClock = 0


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
		return false
		get_parent().ClearTerrain()
	
	return true