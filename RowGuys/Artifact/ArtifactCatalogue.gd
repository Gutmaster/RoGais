extends TextureRect


func _ready():
	pass


func PullRandom():
	randomize()
	return get_node("Grid").get_child(randi()%get_child_count()).Clone()