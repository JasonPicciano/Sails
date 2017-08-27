extends RigidBody2D

var steering_com = 0.0
var force_com = 0.0
var prevTile
var newTile
var boatState
var BasicSeconds = 0
var boat

func _ready():
	set_meta("type","player")
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)
	boat = get_node("/root/env/boat")

	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(8, 20))
	add_shape(shape)
	boatState = 0
	
func _input(event):
	if event.is_action_released("u"):
		find_Nearest_Node()
	if event.is_action_pressed("Spawn Enemy"):
		get_node("/root/env").spawn_Enemy()
	if event.is_action_pressed("HealthUp"):
		get_node("/root/env/CanvasLayer").updateHealth(10)
	if event.is_action_pressed("HealthDown"):
		get_node("/root/env/CanvasLayer").updateHealth(-10)
	
	
func _process(delta):
	BasicSeconds += delta
	if(round(BasicSeconds)>2):
		BasicSeconds = 0
		check_Location()

#Testing Controls

	if (Input.is_key_pressed(KEY_UP)&&not Input.is_key_pressed(KEY_LEFT)&&not Input.is_key_pressed(KEY_RIGHT)):
		force_com = -25
		steering_com = 0
	elif Input.is_key_pressed(KEY_RIGHT):
		steering_com = -512
	elif Input.is_key_pressed(KEY_LEFT):
		steering_com = 512
	if Input.is_key_pressed(KEY_UP):
		force_com = -25
	elif Input.is_key_pressed(KEY_DOWN):
        force_com = 10
	else:
		steering_com = 0
		force_com = 0



func _fixed_process(delta):
    var tf = get_global_transform()
    var vel = get_linear_velocity()

    var right_vel = tf.x * tf.x.dot(vel)

    var force = force_com - force_com * clamp(vel.length() / 400.0, 0.0, 1.0)
    var steering_torque = steering_com
    if tf.y.dot(vel) < 0.0:

        steering_torque = -steering_com

        if force_com <= 0.0:
            force *= 0.9

    apply_impulse(Vector2(), -right_vel * 0.04 * clamp(1.0 / abs(force), 0.01, 1.0))
#  
    apply_impulse(Vector2(), tf.basis_xform(Vector2(0, force)))

    set_applied_torque(steering_torque * vel.length() / 150.0)

func find_Nearest_Node():
	var pos = boat.get_global_pos()
	var x1000 = round(pos.x/1000)*1000
	var y1000 = round(pos.y/1000)*1000
	var array = find_Occupied_Tile()
	var Xtile = array[0]
	var Ytile = array[1]
	var XNode = (Xtile*6000)-x1000
	var YNode = (Ytile*6000)-y1000
	XNode = clamp(XNode, -2000,2000)
	YNode = clamp(YNode,-2000,2000)
	print(str(XNode)," ",str(YNode))
	return[XNode,YNode]
	print(x1000," ",y1000)
	
func find_Occupied_Tile():
	var x = get_global_pos().x
	var y = get_global_pos().y
	
	var Xtile = int(x/3000)
	var Ytile = int(y/3000)
	if (Xtile%2==0&&Xtile!=0&&Xtile>0):
		Xtile = Xtile-1
	if (Ytile%2==0&&Ytile!=0&&Ytile>0):
		Ytile = Ytile-1
	if (Xtile%2==0&&Xtile!=0&&Xtile<0):
		Xtile = Xtile+1
	if (Ytile%2==0&&Ytile!=0&&Ytile<0):
		Ytile = Ytile+1

	if(Xtile>2):
		Xtile = (float(Xtile)/2)+ 0.5
	if(Xtile<-2):
		Xtile = (float(Xtile)/2)- 0.5
	if(Ytile>2):
		Ytile = (float(Ytile)/2)+ 0.5
	if(Ytile<-2):
		Ytile = (float(Ytile)/2)-0.5
	return [Xtile,Ytile]

func check_Location():
	var Xtile = find_Occupied_Tile()[0]
	var Ytile = find_Occupied_Tile()[1]
	
	var corners = Array()
	var corners = [0,0,0,0]
	#array = [left, up, right, down]
	
	if(abs((Xtile*6000)+3000-get_global_pos().x)<1500):
		get_node("/root/env").set_Tile(Xtile+1,Ytile)
		corners[2]=1
	if(abs((Xtile*6000)-3000-get_global_pos().x)<1500):
		get_node("/root/env").set_Tile(Xtile-1,Ytile)
		corners[0]=1
	if(abs((Ytile*6000)+3000-get_global_pos().y)<1500):
		get_node("/root/env").set_Tile(Xtile,Ytile+1)
		corners[3]=1
	if(abs((Ytile*6000)-3000-get_global_pos().y)<1500):
		get_node("/root/env").set_Tile(Xtile,Ytile-1)
		corners[1]=1
		
	var cornerSum = 0
	for i in range(0, corners.size()):
		cornerSum+=corners[i]
	
	if (cornerSum>1):
		if(corners[0]+corners[1]==2):
			get_node("/root/env").set_Tile(Xtile-1,Ytile-1)
		if(corners[1]+corners[2]==2):
			get_node("/root/env").set_Tile(Xtile+1,Ytile-1)
		if(corners[2]+corners[3]==2):
			get_node("/root/env").set_Tile(Xtile+1,Ytile+1)
		if(corners[0]+corners[3]==2):
			get_node("/root/env").set_Tile(Xtile-1,Ytile+1)

func damage(type):
	if type == "cannon":
		get_node("/root/env/CanvasLayer").updateHealth(-20)


