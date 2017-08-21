extends Node2D

var BasicSeconds = 0
var player

func _ready():
	set_fixed_process(true)
	player = get_node("/root/env/boat")
	
	
func _fixed_process(delta):
	BasicSeconds += delta
	if (BasicSeconds>5):
		BasicSeconds = 0
		
		if(self.get_global_pos().distance_to(player.get_global_pos())>3000):
			print("Tile Removed: ",get_name())
			queue_free()
	
