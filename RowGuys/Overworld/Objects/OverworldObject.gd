extends RigidBody2D


onready var eventMenu = $EventMenu/Container


func _ready():
	pass


func wait():
	$CollisionShape2D.disabled = true
	$WaitTimer.start()
	

func wake_up():
	$WaitTimer.stop()
	$CollisionShape2D.disabled = false


func _on_WaitTimer_timeout():
	wake_up()


func create_event():
	eventMenu.visible = true
	Globals.eventScene = eventMenu