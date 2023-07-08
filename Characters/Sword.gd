extends CharacterBody2D



func _physics_process(delta):
	sword_move()

func sword_move():
	var character = get_parent().get_position()
	var mouse = get_parent().get_local_mouse_position()
	if sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y))<=15 and sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y))>=10:
		position.x = mouse.x
		position.y = mouse.y
		
		
