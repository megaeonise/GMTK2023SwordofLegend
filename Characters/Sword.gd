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
	pass

#	else:
#		get_node('SwordCollision').set_disabled(true)


func _on_player_mode_change(mode):
	sword_mode = mode
