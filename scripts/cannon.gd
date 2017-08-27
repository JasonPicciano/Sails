extends RigidBody2D
var BasicSeconds = 0

func _ready():
	#time_start = OS.get_unix_time()
	set_meta("type","attack")
	set_process(true)
	
func _process(delta):
	var bodies = get_colliding_bodies()
	if (bodies.size()>=1):
		bodies[0].damage("cannon")
		queue_free()
	
	BasicSeconds += delta
	if (round(BasicSeconds)>3):
		queue_free()