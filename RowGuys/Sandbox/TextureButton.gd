extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var color = Color(0.1, 0.1, 0.1, 1)


func _ready():
	self_modulate = color