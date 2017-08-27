extends RigidBody2D

var BasicSeconds = 0
var env 

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	env = get_node("/root/env")
	
func _input(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON):
		fireCannon(get_global_mouse_pos())


func fireCannon(target):
	var boat = get_parent().get_global_pos()
	var traj = Vector2((target.x-boat.x),(target.y-boat.y))
	
	var newBulletResource = preload("res://prefabs/cannonEnemy.tscn")
	var newBullet = newBulletResource.instance()
	env.add_child(newBullet)
	newBullet.set_global_pos(boat)
	newBullet.get_node("Sprite").set_rot(traj.angle()-59)
	newBullet.set_linear_velocity(traj.normalized()*400)
	newBullet.set_name("enemyCannonball")

func _fixed_process(delta):
	BasicSeconds += delta
	if (BasicSeconds>.5):
		var enemies = get_colliding_bodies()
		BasicSeconds = 0
		if (enemies.size()>0):
			fireCannon(enemies[0].get_global_pos())
		

	

