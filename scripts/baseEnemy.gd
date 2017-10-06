extends RigidBody2D

var player
var BasicSeconds = 0
var health = 20
var moveTime = 0

func _ready():
	set_fixed_process(true)
	player = get_node("/root/env/boat")

func _fixed_process(delta):
	BasicSeconds += delta
	if (health<= 0):
		queue_free()


#Push if player is found
#Every once in a while check for intersect ray
#if no extra objects move toward player
#If there is an object turn 45 degrees and do an entire push cycle 
	if ((BasicSeconds-moveTime)>.4):
		moveTime=BasicSeconds
		var playerPos = player.get_global_pos()
		var mat32 = get_global_transform()
		print(mat32[1].angle())
		print("Angle to Player: " + str(mat32[1].angle_to(playerPos)))
		#Check to see if rotion is off
		var angleTo = mat32[1].angle_to(playerPos)
		if ((3-abs(angleTo))>.3):
			if(angleTo>0):
				set_applied_torque(350)

			else:
				set_applied_torque(-350)
	
		else:
			set_applied_torque(0)
			if (get_pos().distance_to(playerPos)>2):
				apply_impulse(Vector2(), Vector2(0,20))

#	if (BasicSeconds>.5):
#		BasicSeconds = 0
#		var playerPos = player.get_global_pos()
		
#		var space_state = get_world_2d().get_direct_space_state()
#		var result = space_state.intersect_ray( get_global_pos(), playerPos, [ self ] )
		
#		if (not result.empty()):
#			var objectName = result.collider.get_parent().get_name()
			#print("Hit at point: ", objectName)
			
#			if (objectName == "boat"):
#				moveEnemy(result.normal)
#			else:
#				avoidObject(result.position, result.normal)


#func moveEnemy(normal):
#	set_rot(-(normal.angle()+60))
#	set_linear_velocity(-normal*60)
#	pass
	
func damage(type):
	if type == "cannon":
		health -= 10
	
func avoidObject(position, normal):
	var angleModifier = randi()%2
	var distance = get_global_pos().distance_to(position)
	
	if (angleModifier == 0):
		#print("angleModifier was 0")
		moveEnemy(normal.rotated(-1))
		
	else:
		#print("angleModifier was 1")
		moveEnemy(normal.rotated(1))

func _on_BaseEnemy_body_enter( body ):
	print("Enemy hit by: ", body.get_name())
