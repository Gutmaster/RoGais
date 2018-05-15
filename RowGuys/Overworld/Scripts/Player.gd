extends Area2D

signal food_changed

export (int) var SPEED  	# how fast the player will move (pixels/sec)

enum STATES {STOPPED, MOVING, EVENT}
var state = STOPPED

var velocity = Vector2()  	# the player's movement vector
var destPos = Vector2()		# destination point

var followCheck = false
var following = false


onready var party = get_node("/root/Globals").party


func _ready():
	destPos = null


func _input(event):
	if(state != EVENT):
		if(event is InputEventMouseButton && event.button_index == BUTTON_LEFT):
			if(event.pressed):
				destPos = get_global_mouse_position()
				
				if(!$PlayerCam.current):
					$"../WorldCam".global_position = $PlayerCam.global_position
					$PlayerCam.make_current()
				
				if($FollowTimer.is_stopped()):
					$FollowTimer.start()
					followCheck = true
					#following = true
			else:
				followCheck = false
				following = false
	else:
		followCheck = false
		following = false


func _process(delta):
	velocity = Vector2()
	
	if(state != EVENT):
		if(!followCheck):
			$FollowTimer.stop()
		elif(followCheck && following):
			destPos = get_global_mouse_position()
		
		if(destPos != null):
			velocity.x = destPos.x - position.x
			velocity.y = destPos.y - position.y


			if(destPos.distance_to(position) < 5 && !followCheck && !following):
				destPos = null
			elif(destPos.distance_to(position) < 50 && followCheck && following):
				velocity = Vector2(0,0)

		if(velocity.length() > 0):
			velocity = velocity.normalized() * SPEED
		
			handle_facing(velocity)

			$AnimatedSprite.play()
			state = MOVING
		else:
			$AnimatedSprite.stop()
			state = STOPPED

		position += velocity * delta
	else:
		destPos = global_position
		velocity = Vector2(0,0)

	FoodTimer_check()


func FoodTimer_check():
	if(state == MOVING):
		if($FoodTimer.paused):
			$FoodTimer.paused = false
		if($FoodTimer.is_stopped()):
			$FoodTimer.start()
	elif(state == STOPPED || state == EVENT):
		$FoodTimer.paused = true


func eat_food(count):
	var amt = count
	for i in range(party.get_node("Units").get_child_count()):
		var unit = party.get_node("Units").get_child(i)
		if(amt <= 0 || !unit.eatFlag):
			unit.Starve()
		else:
			unit.Eat()
		
		amt -= 1
	
	party.UpdateFood(-count)
	#emit_signal("food_changed", party.food)


func handle_facing(velocity):
	if(abs(velocity.x) >= abs(velocity.y)):
		$AnimatedSprite.animation = "east"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.flip_h = false
		if(velocity.y > 0):
			$AnimatedSprite.animation = "south"
		else:
			$AnimatedSprite.animation = "north"


func _on_Player_body_entered(body):
	state = EVENT
	body.create_event()


func _on_FoodTimer_timeout():
	var amt = 0
	for i in range(party.get_node("Units").get_child_count()):
		if(party.get_node("Units").get_child(i).eatFlag && amt < party.food):
			amt += 1
	
	eat_food(amt)


func _on_FollowTimer_timeout():
	following = true
	$FollowTimer.stop()