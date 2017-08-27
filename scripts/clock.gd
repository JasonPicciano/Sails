extends Label
#var time_start = 0
#var time_now = 0
var BasicSeconds = 0
var boat 

func _ready():
	boat = get_node("/root/env/boat")
	#time_start = OS.get_unix_time()
	set_process(true)
	
func _process(delta):
	#var elapsed = time_now -time_start
	#var minutes = elapsed/60
	#var seconds = elapsed%60
	#var str_elapsed = "%02d : %02d" % [minutes, seconds]
	#print("elapsed : ", str_elapsed)
	BasicSeconds += delta
	var meh = boat.find_Occupied_Tile()
	set_text("Seconds: " + str(round(BasicSeconds)) + "  ---   # of Tiles: " + str(get_tree().get_nodes_in_group("tile").size())+ "   ----   Current Tile: "+ str(meh[0]) + "," + str(meh[1]))
	#set_text(str(str_elapsed))