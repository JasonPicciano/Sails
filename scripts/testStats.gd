extends RichTextLabel
var testArray
func _ready():
	testArray = {
		"hul":0,
		"spd":0,
		"atk":0,
		"agl":0,
		"crw":0
	}
	updateForm()

func updateStat(stat):
	if(stat=="hull"):
		testArray.hul+=1
	elif(stat=="attack"):
		testArray.atk+=1
	elif(stat=="crew"):
		testArray.crw+=1
	elif(stat=="agility"):
		testArray.agl+=1
	elif(stat=="speed"):
		testArray.spd+=1
	else:
		print("updateStat was given a bad string: " + stat)
	updateForm()

func updateForm():
	clear()
	add_text("Hull: " + str(testArray.hul))
	newline()
	add_text("Crew: " + str(testArray.crw))
	newline()
	add_text("Attack: " + str(testArray.atk))
	newline()
	add_text("Agility: " + str(testArray.agl))
	newline()
	add_text("Speed: " + str(testArray.spd))
