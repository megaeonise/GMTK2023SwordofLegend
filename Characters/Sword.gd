extends CharacterBody2D

var sword_mode = -1
var speed = 1000


func _physics_process(delta):
	var mouse = get_parent().get_local_mouse_position()
	velocity = Vector2(0,0)
	sword_move()
	move_and_slide()

func sword_move():
	if sword_mode==1:
		get_node('SwordCollision').set_disabled(false)
		var character = get_position()
		var mouse = get_parent().get_local_mouse_position()
		var distance_to_mouse = mouse-character
		print(character, mouse)
		if sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y))<=200:
			if abs(distance_to_mouse.x)>=10:
				print(distance_to_mouse.x)
				var direction = (mouse - position).normalized()
				velocity = (direction * speed)

	else:
		get_node('SwordCollision').set_disabled(true)


func _on_player_mode_change(mode):
	sword_mode = mode
