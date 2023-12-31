extends Area2D

signal attack(damage)
var sword_mode = -1
var speed = 1000
var radius = 50
var attack_anim = 0
var is_attack = false
signal parry
#@onready var player_var = get_node("/root/Player")
#var upgrade_arr = player_var.upgrade_arr



func _physics_process(delta):
	var mouse = get_parent().get_local_mouse_position()
	sword_move()
	sword_attack()

func sword_move():
	if sword_mode==1:
#		get_node('SwordCollision').set_disabled(false)
#		self.add_collision_exception_with(get_node('HeroSprite'))
		var mouse_pos = get_global_mouse_position()
		var player_pos = get_parent().global_transform.origin 
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		global_transform.origin = mouse_pos
		if global_position.y > player_pos.y:
			global_position.y = player_pos.y-8
#	else:
#		get_node('SwordCollision').set_disabled(true)

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
			attack.emit(1+(VariableStore.length_upgrade*0.5))
			get_node('SwordCollision').set_disabled(false)
			is_attack = true
		elif get_node('SwordSprite').animation == 'attack2' and get_node('SwordSprite').frame>=1 and get_node('SwordSprite').frame<=2:
			attack.emit(1+(VariableStore.length_upgrade*0.5))
			get_node('SwordCollision').set_disabled(false)
			is_attack = true
		else:
			get_node('SwordCollision').set_disabled(true)
			is_attack = false




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


func _on_projectile_area_entered(area):
	if is_attack:
		parry.emit()

