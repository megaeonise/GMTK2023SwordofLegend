extends CharacterBody2D



func _physics_process(delta):
	sword_move()

func sword_move():
	var character = get_parent().get_position()
	var mouse = get_viewport().get_mouse_position()
	if sqrt(mouse.x-character.x*mouse.x-character.x + mouse.y-character.y*mouse.y-character.y)<=100:
		position = mouse
		
		
