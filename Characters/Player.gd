extends CharacterBody2D
signal mode_change(mode)
var speed = 200
#regular = -1, chained = 1
var mode = -1
var gravity = 200
var grip = 0
var on_ground = false
var hp = 3
var left = false
#sword length/dmg, chain length, grip strength
var points = VariableStore.upgrade_points
var upgrade_arr = [VariableStore.length_upgrade,VariableStore.range_upgrade,VariableStore.grip_upgrade]
#var length_up = 1
#var grip_up = 1
#var chain_up = 1

func _ready():
	add_collision_exception_with(get_node('Sword'))

func _physics_process(delta):
	velocity = Vector2(0,+gravity)
	sword_move()
	move_and_slide()
	direction_finder()
	if hp<=0:
		queue_free()
	
#	if Input.is_action_just_pressed('ui_select'):
#		print(upgrade_arr)
#
#	if Input.is_action_just_pressed('ui_accept'):
#		print('tong')
#		for i in range(3):
#			upgrade_arr[i]+=1
	
	
func sword_move():
	var character = get_position()
	var mouse = get_global_mouse_position()
	var distance_to_mouse = mouse-character
	var local_mouse = get_local_mouse_position()
	
	
	if not on_ground:
		if grip>0:
			grip-=1
		
	if grip==0:
		gravity = 200
	
	#GRIP IS SET HERE!!!
	if is_on_floor():
		#into grip upgrade
		grip = 25+25*(upgrade_arr[2]/2)
		on_ground = true
	
	if Input.is_action_just_pressed("Right_Click") and on_ground==true:
		if not left:
			get_node('Sword').set_position(Vector2(16,-5))
		else:
			get_node('Sword').set_position(Vector2(-16,-5))
		mode*=-1
		mode_change.emit(mode)
	
	if mode==1:
		get_node('HeroSprite').play('cower')
	
	if mode==-1:
		if not left:
			get_node('Sword').set_position(Vector2(16,-5))
		else:
			get_node('Sword').set_position(Vector2(-16,-5))
		get_node('Sword/SwordSprite').play('static')
		get_node('Sword/SwordSprite').pause()
		if abs(distance_to_mouse.x)>=10:
			if Input.is_action_pressed('Left_Click'):
				if mouse.y<position.y-100 and grip>0:
					on_ground = false
					gravity = 0
					get_node('HeroSprite').play('hang')
					if local_mouse.y<-150:
						var direction = (mouse - position).normalized()
						velocity = (direction * speed)
					else:
						var direction = (mouse-position).normalized()
						velocity = (direction * speed * 0.6)
				else:
					if abs(local_mouse.x)>200:
						if on_ground:
							get_node('HeroSprite').play('drag')
						var direction = (mouse - position).normalized()
						velocity.x = (direction.x * speed * 1.00)
					elif abs(local_mouse.x)>110:
						if on_ground:
							get_node('HeroSprite').play('run')
						var direction = (mouse - position).normalized()
						velocity.x = (direction.x * speed * 0.75)
					else:
						if on_ground:
							get_node('HeroSprite').play('walk')
						var direction = (mouse - position).normalized()
						velocity.x = (direction.x * speed * 0.5)
			if not Input.is_action_pressed("Left_Click"):
				if on_ground:
					get_node('HeroSprite').play('stand')
				elif not on_ground:
					gravity = 200

func direction_finder():
	var local_mouse = get_local_mouse_position()
	if local_mouse.x<0:
		left = true
		get_node("HeroSprite").set_flip_h(true)
		get_node("Sword/SwordSprite").set_flip_h(true)
	else:
		left = false
		get_node('HeroSprite').set_flip_h(false)
		get_node("Sword/SwordSprite").set_flip_h(false)




func _on_mushroom_player_damage():
	hp-=1
