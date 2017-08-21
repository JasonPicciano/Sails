extends Node
var testRay
var RayNode
var tile_resource
var boat

func _ready():
	#Build Starting Tiles
	tile_resource = preload("res://prefabs/tile.tscn")
	RayNode = get_node("RayNode")
	testRay = get_node("RayNode/tileTesterRay")
	boat = get_node("/root/env/boat")

	var tile = tile_resource.instance()
	tile.set_pos(Vector2(0,0))
	add_child(tile)
			

func set_Tile(x,y):
	if has_node(str(x)+","+str(y)):
		print("Node Exists: "+str(x)+","+str(y))
		return
	else:
		var tile = tile_resource.instance()
		tile.set_pos(Vector2(x*6000, y*6000))
		tile.set_name(str(x)+","+str(y))
		#rock_Spawner(position, tile)
		#enemy_Spawner(position,tile)
		print("Set Tile: " + tile.get_name())
		add_child(tile)
	
func spawn_Enemy():
		var enemy_resource = preload("res://prefabs/BaseEnemy.tscn")
		var enemy = enemy_resource.instance()
		var node_Array = boat.find_Nearest_Node()
		var tileInt = boat.find_Occupied_Tile()
		var tileStr = "/root/env/"+str(tileInt[0]*6000)+","+str(tileInt[1]*6000)
		var nodeStr = str(node_Array[0])+","+str(node_Array[1])
		var node = get_node(tileStr).get_node(nodeStr)
		enemy.set_pos(node.get_global_pos())
		print("Enemy Spawned at " + str(enemy.get_global_pos()) + str(node.get_name()))
		node.add_child(enemy)

func rock_Spawner(tileCenter, parent):
	var x
	var y
	
	var inverter 
	var chance = randi()%10
	
	if (chance < 4):
		inverter = randi()%1
		if (inverter == 0):
			x = parent.get_pos().x + randi()%200
		else:
			x = parent.get_pos().x + -randi()%200
		
		inverter = randi()%1
		if (inverter == 0):
			y = parent.get_pos().y + randi()%200
		else:
			y = parent.get_pos().y + -randi()%200
		var rock_resource = preload("res://prefabs/rock.tscn")
		var rock = rock_resource.instance()
		rock.set_pos(Vector2(x, y))
		
		#print("rock set: "+ rock.get_name() + String(rock.get_global_pos()))
		#rock.add_to_group("rock")
		add_child(rock)
	#parent.add_child(rock)
	#tile.get_child(1).set_name(String(-1000+(500*x))+","+String(-1000+(500*y)))
	#add_child(tile)
	
