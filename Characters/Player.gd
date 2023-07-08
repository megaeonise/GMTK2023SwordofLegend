extends CharacterBody2D
signal mode_change(mode)
var speed = 350
#regular = -1, chained = 1
var mode = -1
var gravity = 200
var grip = 100
var on_ground = true



func _physics_process(delta):
	velocity = Vector2(0,+gravity)
	sword_move()
	move_and_slide()
	direction_finder()
	
	
func sword_move():
	var character = get_position()
	var mouse = get_global_mouse_position()
	var distance_to_mouse = mouse-character
	var local_mouse = get_local_mouse_position()
	print(local_mouse)
	
	if not on_ground:
		if grip>0:
			grip-=1
		print(grip)
		
	if grip==0:
		gravity = 200
	
	if is_on_floor():
		grip = 100
		on_ground = true
	
	if Input.is_action_just_pressed("Right_Click"):
		get_node('Sword').set_position(Vector2(0,0))
		mode*=-1
		mode_change.emit(mode)
		
	if mode==-1:
		if abs(distance_to_mouse.x)>=10:
			if Input.is_action_pressed('Left_Click'):
				if mouse.y<position.y and grip>0:
					on_ground = false
					gravity = 0
					if local_mouse.y<-150:
						var direction = (mouse - position).normalized()
						velocity = (direction * speed)
					else:
						var direction = (mouse-position).normalized()
						velocity = (direction * speed * 0.6)
				else:
					if abs(local_mouse.x)>200:
						get_node('HeroSprite').play('run')
						var direction = (mouse - position).normalized()
						velocity = (direction * speed * 1.25)
					elif abs(local_mouse.x)>110:
						get_node('HeroSprite').play('run')
						var direction = (mouse - position).normalized()
						velocity = (direction * speed * 1.0)
					else:
						get_node('HeroSprite').play('walk')
						var direction = (mouse - position).normalized()
						velocity = (direction * speed * 0.5)
			if not Input.is_action_pressed("Left_Click"):
				get_node('HeroSprite').play('stand')
				if not on_ground:
					gravity = 200

func direction_finder():
	var local_mouse = get_local_mouse_position()
	if local_mouse.x<0:
		get_node("HeroSprite").set_flip_h(true)
		get_node("Sword/TempSword").set_flip_h(true)
	else:
		get_node('HeroSprite').set_flip_h(false)
		get_node("Sword/TempSword").set_flip_h(false)


