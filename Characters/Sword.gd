extends CharacterBody2D

var sword_mode = -1
var speed = 200

func _physics_process(delta):
	velocity = Vector2(0,0)
	sword_move()
	move_and_slide()

func sword_move():
	if sword_mode==1:
		var character = get_parent().get_position()
		var mouse = get_parent().get_local_mouse_position()
		print(character, mouse)
		if sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y))<=500:
			print(sqrt(abs(mouse.x-character.x*mouse.x-character.x) + abs(mouse.y-character.y*mouse.y-character.y)))
			position = mouse


func _on_player_mode_change(mode):
	sword_mode = mode
