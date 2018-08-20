extends GridContainer


func _ready():
	pass


func PullRandom():
	randomize()
	return get_child(randi()%get_child_count()).Clone()