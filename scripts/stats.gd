extends CanvasLayer
var health
var healthbar
func _ready():
	health = 100
	healthbar = get_node("AnimatedSprite")
	pass
	
func updateHealth(change):
	health = health + change
	var healthcount = round(health/10)*10
	if healthcount > 80:
		healthbar.set_frame(5)
	elif healthcount > 60:
		healthbar.set_frame(4)
	elif healthcount > 40:
		healthbar.set_frame(3)
	elif healthcount > 20:
		healthbar.set_frame(2)
	elif healthcount > 0:
		healthbar.set_frame(1)
	elif health <= 0:
		endGame()


func endGame():
	print("You lost all your health...bitch")
	
