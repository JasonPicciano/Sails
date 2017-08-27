extends Node

var BasicSeconds = 0
var player

func _ready():
	set_meta("type","rock")
	set_fixed_process(true)
	player = get_node("/root/env/boat")


func _on_RigidBody2D_body_enter( body ):
	print("Rock has been STRUCK!: "+body.get_name())
	
func _fixed_process(delta):
	BasicSeconds += delta
	if (BasicSeconds>5):
		BasicSeconds = 0
		