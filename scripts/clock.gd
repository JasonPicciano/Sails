extends Label
#var time_start = 0
#var time_now = 0
var BasicSeconds = 0

func _ready():
	#time_start = OS.get_unix_time()
	set_process(true)
	
func _process(delta):
	#var elapsed = time_now -time_start
	#var minutes = elapsed/60
	#var seconds = elapsed%60
	#var str_elapsed = "%02d : %02d" % [minutes, seconds]
	#print("elapsed : ", str_elapsed)
	BasicSeconds += delta
	set_text("Seconds: " + str(round(BasicSeconds)))
	#set_text(str(str_elapsed))