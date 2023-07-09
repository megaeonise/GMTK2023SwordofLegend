extends CharacterBody2D

signal collided_with(object)

func _physics_process(delta):
	move_and_slide()
	for collisions in get_slide_collision_count():
		var collision = get_slide_collision(collisions)
		collided_with.emit(collision.get_collider().name)
		print(collision.get_collider().name)
