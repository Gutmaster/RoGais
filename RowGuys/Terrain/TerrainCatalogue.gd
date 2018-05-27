extends AnimatedSprite


var tags = {"exists": false, "blocking": false, "target": false, "trapping": false}

var maxhp = 1000
var hp = 1000


func _ready():
	pass


func Init(left):
	if(!left):
		set_flip_h(true)
	animation = "Start"
	play()


func Upkeep():
	pass