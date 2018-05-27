extends AnimatedSprite

onready var player = $"../Player"


func _process(delta):
	if(player.state == player.STATES.STOPPED || player.state == player.STATES.EVENT):
		visible = false
	else:
		if(player.destPos != null):
			visible = true
			global_position = player.destPos
		
