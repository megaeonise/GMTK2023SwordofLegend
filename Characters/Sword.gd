extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	sword_move()
	move_and_slide()

func sword_move():
	var character = get_parent().get_position()
	var mouse = get_parent().get_local_mouse_position()
#	var sword_distance = sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y))
#	if sword_distance<=20 and sword_distance>=10:
#		position.x = mouse.x
#		position.y = mouse.y
	var direction = (mouse - position).normalized()
	velocity = (direction * speed)
