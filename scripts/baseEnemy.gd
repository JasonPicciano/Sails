extends RigidBody2D

var player
var BasicSeconds = 0
var health = 20

func _ready():
	set_fixed_process(true)
	player = get_node("/root/env/boat")

func _fixed_process(delta):
	BasicSeconds += delta
	if (health<= 0):
		queue_free()

	if (BasicSeconds>.5):
		BasicSeconds = 0
		var playerPos = player.get_global_pos()
		
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray( get_global_pos(), playerPos, [ self ] )
		
		if (not result.empty()):
			var objectName = result.collider.get_parent().get_name()
			#print("Hit at point: ", objectName)
			
			if (objectName == "boat"):
				moveEnemy(result.normal)
			else:
				avoidObject(result.position, result.normal)


func moveEnemy(normal):
	set_rot(-(normal.angle()+60))
	set_linear_velocity(-normal*60)
	pass
	
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
