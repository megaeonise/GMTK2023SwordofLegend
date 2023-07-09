extends CharacterBody2D

var sword_mode = -1
var speed = 1000
var radius = 50



func _physics_process(delta):
	var mouse = get_parent().get_local_mouse_position()
	velocity = Vector2(0,0)
	sword_move()
	move_and_slide()

func sword_move():
	if sword_mode==1:
		get_node('SwordCollision').set_disabled(false)
#		var hero = get_parent().position
#		var global_hero = get_parent().global_position
#		var global_sword = global_position
#		var mouse = get_parent().get_local_mouse_position()
		var mouse_pos = get_global_mouse_position()
		var player_pos = get_parent().global_position
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		self.global_transform.origin = mouse_pos
##		var distance_to_mouse = mouse-sword
##		if global_sword.distance_to(global_hero)<=300:
#		if mouse.distance_to(position)>=10:
#			var direction = (mouse-position).normalized()
#			velocity = (direction * speed)
#			print('radius:',radius,' position distance to', global_position.distance_to(global_hero), 'hero:', global_hero)
##			if global_sword.distance_to(global_hero)>radius:
##				position = (direction*radius)


	else:
		get_node('SwordCollision').set_disabled(true)


func _on_player_mode_change(mode):
	sword_mode = mode
