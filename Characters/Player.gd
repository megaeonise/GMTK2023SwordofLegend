extends CharacterBody2D

var speed = 350

func _physics_process(delta):
	movement()

func movement():
	print(position)
	var sword_pos = get_node("Sword").get_position()
	position = sword_pos

	
