extends CharacterBody2D

signal attack(damage)
var sword_mode = -1
var speed = 1000
var radius = 50
var attack_anim = 0



func _physics_process(delta):
	var mouse = get_parent().get_local_mouse_position()
	velocity = Vector2(0,0)
	sword_move()
	sword_attack()
	move_and_slide()

func sword_move():
	if sword_mode==1:
		get_node('SwordCollision').set_disabled(false)
		self.add_collision_exception_with(get_node('HeroSprite'))
		var mouse_pos = get_global_mouse_position()
		var player_pos = get_parent().global_transform.origin 
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		global_transform.origin = mouse_pos
		if position.y > player_pos.y:
			position.y = player_pos.y+8

func sword_attack():
	if sword_mode ==1:
		if Input.is_action_just_pressed("Left_Click"):
			if get_node('SwordSprite').is_playing()==false:
				if attack_anim==0:
					get_node('SwordSprite').play('attack')
					attack_anim = 1
					get_node('Buffer').start()
				else:
					get_node('SwordSprite').play('attack2')
					attack_anim = 0
		if get_node('SwordSprite').animation == 'attack' and get_node('SwordSprite').frame>=2 and get_node('SwordSprite').frame<=3:
			attack.emit(1)
			print('down')
		if get_node('SwordSprite').animation == 'attack2' and get_node('SwordSprite').frame>=1 and get_node('SwordSprite').frame<=2:
			attack.emit(1)
			print('up')
			

#	else:
#		get_node('SwordCollision').set_disabled(true)


func _on_player_mode_change(mode):
	sword_mode = mode


func _on_sword_sprite_animation_finished():
#	if sword_mode==-1:
#		get_node('SwordSprite').play('static')
#		get_node('SwordSprite').pause()
	if attack_anim==0:
		get_node('SwordSprite').play('static2')
		get_node('SwordSprite').pause()
	else:
		get_node('SwordSprite').play('static3')
		get_node('SwordSprite').pause()


func _on_buffer_timeout():
	attack_anim = 0
	if get_node('SwordSprite').is_playing()==false:
		get_node('SwordSprite').play('static2')
		get_node('SwordSprite').pause()
