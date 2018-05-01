extends Label


var lifetime = 0
var maxLifetime = 100


func _ready():
	set_process(false)


func Set(amount, color):
	rect_position = Vector2(0,0)
	visible = true
	set_process(true)
	text = str(amount)
	set("custom_colors/font_color", color)


func _process(delta):
	lifetime += 50*delta
	if(lifetime > maxLifetime):
		lifetime = 0
		visible = false
		set_process(false)
	
	rect_position.y = -lifetime