extends CharacterBody2D
signal mode_change(mode)
var speed = 350
#regular = -1, chained = 1
var mode = -1



func _physics_process(delta):
	velocity = Vector2(0,0)
	sword_move()
	move_and_slide()
	
#func movement():
#	print(position)
#	var sword_pos = get_node("Sword").get_position()
#	position = sword_pos
	
func sword_move():
	var character = get_position()
	var mouse = get_global_mouse_position()
	var distance_to_mouse = mouse-character
	if Input.is_action_just_pressed("Right_Click"):
		get_node('Sword').set_position(Vector2(0,0))
		mode*=-1
		mode_change.emit(mode)
	if mode==-1:
		if abs(distance_to_mouse.x)>=10:
			if Input.is_action_pressed('Left_Click'):
				var direction = (mouse - position).normalized()
				velocity = (direction * speed)


