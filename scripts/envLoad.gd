extends Node
var tile_resource
var boat
var gameTime
var rockNeed
var rockCount

func _ready():
	gameTime = 0
	rockNeed = 20
	set_process(true)
	#Build Starting Tiles
	tile_resource = preload("res://prefabs/tile.tscn")
	boat = get_node("/root/env/boat")

	var tile = tile_resource.instance()
	tile.set_pos(Vector2(0,0))
	add_child(tile)
			

func _process(delta):
	gameTime += delta

func set_Tile(x,y):
	if has_node(str(x)+","+str(y)):
		print("Node Exists: "+str(x)+","+str(y))
		return
	else:
		var tile = tile_resource.instance()
		tile.set_pos(Vector2(x*6000, y*6000))
		tile.set_name(str(x)+","+str(y))
		
		print("Set Tile: " + tile.get_name())
		add_child(tile)
		remove_Tiles(x,y)
		rock_Spawner(tile)

func remove_Tiles(newX,newY):
	var currentTile = boat.find_Occupied_Tile()
	var searchArray
	if currentTile[0]>newX:
		#print("moving left")
		searchArray = [str(currentTile[0]+1)+","+str(currentTile[1]-1),str(currentTile[0]+1)+","+str(currentTile[1]),str(currentTile[0]+1)+","+str(currentTile[1]+1)]
	elif currentTile[0]<newX:
		#print("moving right")
		searchArray = [str(currentTile[0]-1)+","+str(currentTile[1]-1),str(currentTile[0]-1)+","+str(currentTile[1]),str(currentTile[0]-1)+","+str(currentTile[1]+1)]
	elif currentTile[1]>newY:
		#print("moving up")
		searchArray = [str(currentTile[0]-1)+","+str(currentTile[1]+1),str(currentTile[0])+","+str(currentTile[1]+1),str(currentTile[0]+1)+","+str(currentTile[1]+1)]
	elif currentTile[1]<newY:
		#print("moving down")
		searchArray = [str(currentTile[0]-1)+","+str(currentTile[1]-1),str(currentTile[0])+","+str(currentTile[1]-1),str(currentTile[0]+1)+","+str(currentTile[1]-1)]
	for i in range(3):
		if self.has_node(searchArray[i]):
			#print("Found node: " + searchArray[i] + " And DESTROYED IT")
			get_node(searchArray[i]).queue_free()
	
func spawn_Enemy():
		var enemy_resource = preload("res://prefabs/BaseEnemy.tscn")
		var enemy = enemy_resource.instance();
		var node_Array = boat.find_Nearest_Node()
		var tileInt = boat.find_Occupied_Tile()
		var tileStr = "/root/env/"+str(tileInt[0]*6000)+","+str(tileInt[1]*6000)
		var nodeStr = str(node_Array[0])+","+str(node_Array[1])
		var node = get_node(tileStr).get_node(nodeStr)
		enemy.set_pos(node.get_global_pos())
		print("Enemy Spawned at " + str(enemy.get_global_pos()) + str(node.get_name()))
		enemy.set_name("Enemy")
		node.add_child(enemy)

func rock_Spawner(tile):
	rockCount = 0
	while rockCount < rockNeed:
		rock_inserter(tile)

func rock_inserter(tile):
	for i in range(25):
		var node = tile.get_child(i)
		if node.has_node("rock"):
			pass
			#print("node has a rock")
		else:
			#print("node needs a rock")
			var inverterx = randi()%1
			var invertery = randi()%1
			var x
			var y
			if (inverterx == 0):
				x = node.get_global_pos().x + randi()%200
			else:
				x = node.get_global_pos().x + -randi()%200
			if (invertery == 0):
				y = node.get_global_pos().y + randi()%200
			else:
				y = node.get_global_pos().y + -randi()%200
			var rock_resource = preload("res://prefabs/rock.tscn")
			var rock = rock_resource.instance()
			rock.set_name("rock")
			rock.set_global_pos(Vector2(x, y))
			rockCount+=1
			node.add_child(rock)