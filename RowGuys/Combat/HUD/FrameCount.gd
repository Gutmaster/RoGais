extends Label

var frames = 0
var time = 0


func _ready():
	pass


func _process(delta):
	frames += 1
	time += delta
	if(time > 1000):
		time = 0
		text = str(frames)
		frames = 0