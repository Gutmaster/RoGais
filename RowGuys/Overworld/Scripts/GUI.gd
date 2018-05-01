extends MarginContainer

"""onready var number_label = $Bars/FoodBar/Count/Background/Number
onready var bar = $Bars/FoodBar/TextureProgress

var animated_food = 0
"""

func _ready():
	pass
	"""var player_max_food = get_node("/root/Globals").party.max_food
	animated_food = player_max_food
	bar.max_value = player_max_food
	UpdateFood(player_max_food)


func UpdateFood(new_value):
	$Tween.interpolate_property(self, "animated_food", animated_food, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#if not $Tween.is_active():
	$Tween.start()


func _process(delta):
	var round_value = round(animated_food)
	number_label.text = str(round_value)
	bar.value = round_value"""