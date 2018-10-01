extends "res://Terrain/TerrainCatalogue.gd"


func _ready():
	tags.exists = true


func Init(left, usr, actn):
	hp = 2
	
	user = usr
	action = actn
	if(!left):
		set_flip_h(true)
	animation = "Start"
	play()


func _process(delta):
	$LifeLabel.text = str(hp)


func OccupantUpkeep(occupant):
	occupant.CombatDamage(user, level, action, false)


func _on_Magma_Rift_animation_finished():
	if(animation == "Start"):
		animation = "Loop"